using Microsoft.EntityFrameworkCore;
using Npgsql;
using NpgsqlTypes;

namespace ReprocessingsApi.Data;

public sealed class ReprocessingsQuery
{
    private readonly AppDbContext _db;

    public ReprocessingsQuery(AppDbContext db) => _db = db;

    public async Task<IReadOnlyList<RowItem>> RunAsync(
        DateTime? fromUtc,
        DateTime? toUtc,
        int? deviceId,
        int? endoscopeId,
        int? errorNumber,
        bool onlyFailed,
        bool singleErrorOnly,
        int limit,
        CancellationToken ct = default)
    {
        // Cycle-base CTE: one row per cycle joined to endoscope + (best-effort)
        // reprocessing device picked from any of its history items.
        //
        // Errors CTEs: union the etddouble and etd5 error tables, mapped onto
        // the cycle they belong to via cyclestep -> reprocessinghistoryitem.
        //
        // Final result: error rows for cycles that have errors + a single
        // cycle-only row for cycles that don't.
        const string sql = """
            WITH cycle_base AS (
                SELECT
                    c.id::bigint                                       AS "CycleId",
                    (c.starttime AT TIME ZONE 'UTC')                   AS "StartedAt",
                    (c.endtime   AT TIME ZONE 'UTC')                   AS "FinishedAt",
                    (cs.name = 'Complete')                             AS "IsSuccess",
                    NULL::text                                         AS "ProgramName",
                    COALESCE(LOWER(REPLACE(rdt.typename, ' ', '')),
                             'unknown')                                AS "DeviceFamily",

                    e.id::bigint                                       AS "EndoscopeId",
                    e.serialnumber                                     AS "EndoscopeSerial",
                    et.typename                                        AS "EndoscopeTypeLabel",
                    m.name                                             AS "EndoscopeManufacturer",

                    rd.id::bigint                                      AS "ReprocessingDeviceId",
                    rd.name                                            AS "ReprocessingDeviceLabel",
                    rd.serialnumber                                    AS "ReprocessingDeviceSerial",
                    rd.location                                        AS "ReprocessingDeviceLocation",
                    NULL::text                                         AS "DepartmentName"
                FROM cycle c
                LEFT JOIN cyclestate    cs ON cs.id = c.cyclestate_id
                LEFT JOIN endoscope     e  ON e.id  = c.endoscope_id
                LEFT JOIN endoscopetype et ON et.id = e.endoscopetype_id
                LEFT JOIN manufacturer  m  ON m.id  = et.manufacturer_id
                LEFT JOIN LATERAL (
                    SELECT rd2.id, rd2.name, rd2.serialnumber, rd2.location, rd2.reprocessingdevicetype_id
                    FROM cyclestep cstep
                    JOIN reprocessinghistoryitem rhi ON rhi.id = cstep.reprocessinghistoryitem_id
                    JOIN reprocessingdevice      rd2 ON rd2.id = rhi.reprocessingdevice_id
                    WHERE cstep.cycle_id = c.id
                    ORDER BY rhi.starttime
                    LIMIT 1
                ) rd ON true
                LEFT JOIN reprocessingdevicetype rdt ON rdt.id = rd.reprocessingdevicetype_id
            ),
            error_rows AS (
                SELECT
                    cb.*,
                    ep.errornumber                              AS "ErrorNumber",
                    ep.errordescription                         AS "ErrorDescription",
                    ep.blocknumber                              AS "BlockNumber",
                    ep.stepnumber                               AS "StepNumber",
                    (ep.errortime AT TIME ZONE 'UTC')           AS "ErrorTime",
                    NULL::int                                   AS "CabinetPosition"
                FROM cycle_base cb
                JOIN cyclestep cstep ON cstep.cycle_id = cb."CycleId"
                JOIN etddoubleerrorprotocol ep
                  ON ep.reprocessinghistoryitem_id = cstep.reprocessinghistoryitem_id

                UNION ALL

                SELECT
                    cb.*,
                    ep.errorno                                  AS "ErrorNumber",
                    COALESCE(ep.shorttext, ep.longtext)         AS "ErrorDescription",
                    ep.blocknumber                              AS "BlockNumber",
                    ep.stepid                                   AS "StepNumber",
                    (ep.errortime AT TIME ZONE 'UTC')           AS "ErrorTime",
                    NULL::int                                   AS "CabinetPosition"
                FROM cycle_base cb
                JOIN cyclestep cstep ON cstep.cycle_id = cb."CycleId"
                JOIN etd5errorprotocol ep
                  ON ep.reprocessinghistoryitem_id = cstep.reprocessinghistoryitem_id
            ),
            single_error_cycles AS (
                SELECT "CycleId"
                FROM error_rows
                GROUP BY "CycleId"
                HAVING COUNT(*) = 1
            ),
            cycle_only_rows AS (
                SELECT
                    cb.*,
                    NULL::int                                   AS "ErrorNumber",
                    NULL::text                                  AS "ErrorDescription",
                    NULL::int                                   AS "BlockNumber",
                    NULL::int                                   AS "StepNumber",
                    NULL::timestamptz                           AS "ErrorTime",
                    NULL::int                                   AS "CabinetPosition"
                FROM cycle_base cb
                WHERE NOT EXISTS (
                    SELECT 1 FROM error_rows er WHERE er."CycleId" = cb."CycleId"
                )
            ),
            all_rows AS (
                SELECT * FROM error_rows
                UNION ALL
                SELECT * FROM cycle_only_rows
            )
            SELECT *
            FROM all_rows
            WHERE
                  (@fromUtc::timestamptz IS NULL OR "StartedAt" >= @fromUtc)
              AND (@toUtc::timestamptz   IS NULL OR "StartedAt" <  @toUtc)
              AND (@deviceId::int        IS NULL OR "ReprocessingDeviceId" = @deviceId)
              AND (@endoscopeId::int     IS NULL OR "EndoscopeId" = @endoscopeId)
              AND (@errorNumber::int     IS NULL OR "ErrorNumber" = @errorNumber)
              AND (NOT @onlyFailed       OR NOT ("IsSuccess" AND "ErrorNumber" IS NULL))
              AND (NOT @singleErrorOnly  OR "CycleId" IN (SELECT "CycleId" FROM single_error_cycles))
            ORDER BY
                "StartedAt" DESC,
                "CycleId",
                COALESCE("BlockNumber", 2147483647),
                COALESCE("StepNumber", 2147483647),
                COALESCE("ErrorTime", TIMESTAMPTZ 'infinity')
            LIMIT @limit;
            """;

        var parameters = new[]
        {
            Param("fromUtc",     fromUtc,     NpgsqlDbType.TimestampTz),
            Param("toUtc",       toUtc,       NpgsqlDbType.TimestampTz),
            Param("deviceId",    deviceId,    NpgsqlDbType.Integer),
            Param("endoscopeId", endoscopeId, NpgsqlDbType.Integer),
            Param("errorNumber", errorNumber, NpgsqlDbType.Integer),
            new NpgsqlParameter("onlyFailed",      NpgsqlDbType.Boolean) { Value = onlyFailed },
            new NpgsqlParameter("singleErrorOnly", NpgsqlDbType.Boolean) { Value = singleErrorOnly },
            new NpgsqlParameter("limit",           NpgsqlDbType.Integer) { Value = limit },
        };

        return await _db.Database
            .SqlQueryRaw<RowItem>(sql, parameters)
            .ToListAsync(ct);
    }

    private static NpgsqlParameter Param(string name, object? value, NpgsqlDbType type) =>
        new(name, type) { Value = value ?? DBNull.Value };
}
