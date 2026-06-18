using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ReprocessingsApi.Data;

var builder = WebApplication.CreateBuilder(args);

builder.Services.ConfigureHttpJsonOptions(o =>
{
    o.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
    o.SerializerOptions.DefaultIgnoreCondition = JsonIgnoreCondition.Never;
    o.SerializerOptions.WriteIndented = false;
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "Reprocessings API",
        Version = "v1",
        Description = "Endpoints for querying endoscope reprocessing cycles and error events."
    });
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException(
        "Connection string 'DefaultConnection' is not configured. " +
        "Set it in appsettings.json, user secrets, or the ConnectionStrings__DefaultConnection environment variable.");

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(connectionString));

builder.Services.AddScoped<ReprocessingsQuery>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Reprocessings API v1");
    });
}

app.MapGet("/api/reprocessings", async (
    ReprocessingsQuery query,
    HttpRequest http,
    [FromQuery] string? from,
    [FromQuery] string? to,
    [FromQuery] int? deviceId,
    [FromQuery] int? endoscopeId,
    [FromQuery] int? errorNumber,
    [FromQuery] bool? onlyFailed,
    [FromQuery] bool? singleErrorOnly,
    [FromQuery] int? limit,
    CancellationToken ct) =>
{
    var errors = new Dictionary<string, string>();

    DateTime? fromUtc = null;
    DateTime? toUtc = null;

    if (!string.IsNullOrWhiteSpace(from))
    {
        if (TryParseIso8601Utc(from, out var v)) fromUtc = v;
        else errors["from"] = "must be a valid ISO 8601 timestamp";
    }
    if (!string.IsNullOrWhiteSpace(to))
    {
        if (TryParseIso8601Utc(to, out var v)) toUtc = v;
        else errors["to"] = "must be a valid ISO 8601 timestamp";
    }

    if (errors.Count > 0)
    {
        return Results.Json(new ErrorBody("invalid_params", errors), statusCode: 400);
    }

    var effectiveLimit = Math.Clamp(limit ?? 5000, 1, 10000);
    var effectiveOnlyFailed = onlyFailed ?? false;
    var effectiveSingleErrorOnly = singleErrorOnly ?? false;

    try
    {
        var rows = await query.RunAsync(
            fromUtc, toUtc, deviceId, endoscopeId, errorNumber,
            effectiveOnlyFailed, effectiveSingleErrorOnly, effectiveLimit, ct);

        var response = new ReprocessingsResponse(
            Items: rows,
            Count: rows.Count,
            GeneratedAt: DateTime.UtcNow,
            SourceUrl: BuildSourceUrl(http)
        );
        return Results.Json(response);
    }
    catch (Exception ex)
    {
        return Results.Json(new InternalErrorBody("internal_error", ex.Message), statusCode: 500);
    }
})
.WithName("GetReprocessings")
.WithTags("Reprocessings")
.WithSummary("List reprocessing cycles and error events")
.WithDescription("Returns reprocessing cycle rows (one per error event, or one cycle-only row when no errors). Supports filtering by date range, device, endoscope, error number, and a failed-only flag.")
.Produces<ReprocessingsResponse>(StatusCodes.Status200OK)
.Produces<ErrorBody>(StatusCodes.Status400BadRequest)
.Produces<InternalErrorBody>(StatusCodes.Status500InternalServerError)
.WithOpenApi(op =>
{
    var descriptions = new Dictionary<string, string>
    {
        ["from"]        = "Inclusive lower bound on cycle start time (ISO 8601, e.g. 2022-06-15T00:00:00Z).",
        ["to"]          = "Exclusive upper bound on cycle start time (ISO 8601).",
        ["deviceId"]    = "Filter by reprocessing device id.",
        ["endoscopeId"] = "Filter by endoscope id.",
        ["errorNumber"] = "Filter by error number.",
        ["onlyFailed"]       = "If true, only return cycles that failed or have error rows.",
        ["singleErrorOnly"]  = "If true, only return cycles that produced exactly one error event.",
        ["limit"]            = "Max rows to return (1-10000, default 5000).",
    };
    foreach (var p in op.Parameters)
    {
        if (descriptions.TryGetValue(p.Name, out var d)) p.Description = d;
    }
    return op;
});

app.Run();

// ---------- helpers ----------

static bool TryParseIso8601Utc(string raw, out DateTime utc)
{
    var styles = DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal;
    if (DateTime.TryParse(raw, CultureInfo.InvariantCulture, styles, out utc))
    {
        utc = DateTime.SpecifyKind(utc, DateTimeKind.Utc);
        return true;
    }
    return false;
}

static string BuildSourceUrl(HttpRequest http)
{
    var qs = http.QueryString.HasValue ? http.QueryString.Value : string.Empty;
    return $"{http.Path}{qs}";
}

// ---------- response envelopes ----------

public sealed record ReprocessingsResponse(
    IReadOnlyList<RowItem> Items,
    int Count,
    DateTime GeneratedAt,
    string SourceUrl
);

public sealed record ErrorBody(
    [property: JsonPropertyName("error")] string Error,
    [property: JsonPropertyName("details")] IReadOnlyDictionary<string, string> Details
);

public sealed record InternalErrorBody(
    [property: JsonPropertyName("error")] string Error,
    [property: JsonPropertyName("message")] string Message
);

// ---------- row shape (one error event per row, snake_case JSON) ----------

public sealed record RowItem
{
    [JsonPropertyName("cycle_id")]                public required long CycleId { get; init; }
    [JsonPropertyName("started_at")]              public required DateTime StartedAt { get; init; }
    [JsonPropertyName("finished_at")]             public DateTime? FinishedAt { get; init; }
    [JsonPropertyName("is_success")]              public required bool IsSuccess { get; init; }
    [JsonPropertyName("programname")]             public string? ProgramName { get; init; }
    [JsonPropertyName("device_family")]           public required string DeviceFamily { get; init; }

    [JsonPropertyName("endoscope_id")]            public long? EndoscopeId { get; init; }
    [JsonPropertyName("endoscope_serial")]        public string? EndoscopeSerial { get; init; }
    [JsonPropertyName("endoscope_type_label")]    public string? EndoscopeTypeLabel { get; init; }
    [JsonPropertyName("endoscope_manufacturer")]  public string? EndoscopeManufacturer { get; init; }

    [JsonPropertyName("reprocessingdevice_id")]        public long? ReprocessingDeviceId { get; init; }
    [JsonPropertyName("reprocessingdevice_label")]     public string? ReprocessingDeviceLabel { get; init; }
    [JsonPropertyName("reprocessingdevice_serial")]    public string? ReprocessingDeviceSerial { get; init; }
    [JsonPropertyName("reprocessingdevice_location")]  public string? ReprocessingDeviceLocation { get; init; }
    [JsonPropertyName("department_name")]              public string? DepartmentName { get; init; }

    [JsonPropertyName("errornumber")]      public int?      ErrorNumber { get; init; }
    [JsonPropertyName("errordescription")] public string?   ErrorDescription { get; init; }
    [JsonPropertyName("blocknumber")]      public int?      BlockNumber { get; init; }
    [JsonPropertyName("stepnumber")]       public int?      StepNumber { get; init; }
    [JsonPropertyName("errortime")]        public DateTime? ErrorTime { get; init; }
    [JsonPropertyName("cabinetposition")]  public int?      CabinetPosition { get; init; }
}

// ---------- in-memory sample data (replace with real DB query) ----------

public static class SampleData
{
    // Total number of rows generated. Override at startup via SampleData:RowCount in appsettings.
    public static int RowCount { get; set; } = 1000;

    private static IReadOnlyList<RowItem>? _cached;
    public static IReadOnlyList<RowItem> AllRows => _cached ??= Generate(RowCount);

    public static IReadOnlyList<RowItem> GenerateRows(int totalRows) => Generate(totalRows);

    private static readonly (string Family, string Label, long DeviceId, string Serial, string Location, string Department)[] Devices =
    {
        ("etddouble", "ETD Double",       12, "12345",   "Jaron",       "Jaron"),
        ("edc",       "EDC Plus nr. 1",   42, "EDC-1",   "Jaron",       "Jaron"),
        ("etdv3",     "ETD v3",           27, "27-A",    "Endoscopy 2", "Endoscopy 2"),
        ("etdv3",     "ETD v3",           28, "28-B",    "Endoscopy 3", "Endoscopy 3"),
        ("edc",       "EDC Plus nr. 2",   43, "EDC-2",   "Endoscopy 1", "Endoscopy 1"),
    };

    private static readonly (long Id, string Serial, string Type, string Manufacturer)[] Endoscopes =
    {
        (8,  "000074381007", "GIF-1TQ160", "Olympus"),
        (9,  "000074381099", "CF-Q150L",   "Olympus"),
        (10, "000074381111", "GIF-H190",   "Olympus"),
        (11, "000074382000", "BF-TE2",     "Olympus"),
        (12, "000074382101", "PCF-H190L",  "Olympus"),
        (13, "000074382202", "TJF-Q190V",  "Olympus"),
    };

    private static readonly string?[] Programs =
    {
        "Ocean 3 Flex Standard Dauer cw",
        "Ocean 3 Flex Short cw",
        "WD thermal self disinfection",
        null,
    };

    private static readonly (int Number, string Description)[] Errors =
    {
        (3003, "Druckluft in APC[1]-Eingang außerhalb des zulässigen Bereichs"),
        (3057, "Pumpendruck für obere Ebene außerhalb des zulässigen Bereichs"),
        (12,   "Leak detected in cabinet position"),
        (1041, "Temperature out of tolerance during disinfection"),
        (2208, "Detergent dosing pump fault"),
        (4500, "Door interlock failure"),
    };

    private static IReadOnlyList<RowItem> Generate(int totalRows)
    {
        var rng = new Random(42);
        var rows = new List<RowItem>(totalRows);
        var startBase = new DateTime(2022, 1, 1, 0, 0, 0, DateTimeKind.Utc);

        long cycleId = 1000;
        while (rows.Count < totalRows)
        {
            cycleId++;
            var device = Devices[rng.Next(Devices.Length)];
            var endoscope = Endoscopes[rng.Next(Endoscopes.Length)];
            var program = Programs[rng.Next(Programs.Length)];

            var startedAt = startBase
                .AddDays(rng.Next(0, 1500))
                .AddMinutes(rng.Next(0, 24 * 60));
            var durationMinutes = rng.Next(20, 90);
            var finishedAt = startedAt.AddMinutes(durationMinutes);

            // 30% of cycles fail with 1-3 error rows; otherwise a single success row.
            var fails = rng.NextDouble() < 0.30;

            if (!fails)
            {
                rows.Add(BuildBaseRow(cycleId, startedAt, finishedAt, true, program, device, endoscope));
                continue;
            }

            var errorCount = rng.Next(1, 4);
            for (var i = 0; i < errorCount && rows.Count < totalRows; i++)
            {
                var err = Errors[rng.Next(Errors.Length)];
                var row = BuildBaseRow(cycleId, startedAt, finishedAt, false, program, device, endoscope) with
                {
                    ErrorNumber = err.Number,
                    ErrorDescription = err.Description,
                    BlockNumber = rng.Next(1, 5),
                    StepNumber = rng.Next(1000, 5000),
                    ErrorTime = startedAt.AddMinutes(rng.Next(1, durationMinutes)),
                    CabinetPosition = device.Family == "edc" ? rng.Next(1, 8) : null,
                };
                rows.Add(row);
            }
        }

        return rows;
    }

    private static RowItem BuildBaseRow(
        long cycleId,
        DateTime startedAt,
        DateTime finishedAt,
        bool isSuccess,
        string? program,
        (string Family, string Label, long DeviceId, string Serial, string Location, string Department) device,
        (long Id, string Serial, string Type, string Manufacturer) endoscope) => new()
    {
        CycleId = cycleId,
        StartedAt = startedAt,
        FinishedAt = finishedAt,
        IsSuccess = isSuccess,
        ProgramName = program,
        DeviceFamily = device.Family,
        EndoscopeId = endoscope.Id,
        EndoscopeSerial = endoscope.Serial,
        EndoscopeTypeLabel = endoscope.Type,
        EndoscopeManufacturer = endoscope.Manufacturer,
        ReprocessingDeviceId = device.DeviceId,
        ReprocessingDeviceLabel = device.Label,
        ReprocessingDeviceSerial = device.Serial,
        ReprocessingDeviceLocation = device.Location,
        DepartmentName = device.Department,
    };

    // Original hand-curated sample (kept for reference; not currently used).
    private static readonly IReadOnlyList<RowItem> _curatedSeed = new List<RowItem>
    {
        // cycle 3124: ETD Double, two errors
        new()
        {
            CycleId = 3124,
            StartedAt = DateTime.Parse("2022-06-15T11:36:21Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            FinishedAt = DateTime.Parse("2022-06-15T12:19:33Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            IsSuccess = false,
            ProgramName = "Ocean 3 Flex Standard Dauer cw",
            DeviceFamily = "etddouble",
            EndoscopeId = 8,
            EndoscopeSerial = "000074381007",
            EndoscopeTypeLabel = "GIF-1TQ160",
            EndoscopeManufacturer = "Olympus",
            ReprocessingDeviceId = 12,
            ReprocessingDeviceLabel = "ETD Double",
            ReprocessingDeviceSerial = "12345",
            ReprocessingDeviceLocation = "Jaron",
            DepartmentName = "Jaron",
            ErrorNumber = 3003,
            ErrorDescription = "Druckluft in APC[1]-Eingang außerhalb des zulässigen Bereichs",
            BlockNumber = 2,
            StepNumber = 4240,
            ErrorTime = DateTime.Parse("2022-06-15T11:38:02Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            CabinetPosition = null,
        },
        new()
        {
            CycleId = 3124,
            StartedAt = DateTime.Parse("2022-06-15T11:36:21Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            FinishedAt = DateTime.Parse("2022-06-15T12:19:33Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            IsSuccess = false,
            ProgramName = "Ocean 3 Flex Standard Dauer cw",
            DeviceFamily = "etddouble",
            EndoscopeId = 8,
            EndoscopeSerial = "000074381007",
            EndoscopeTypeLabel = "GIF-1TQ160",
            EndoscopeManufacturer = "Olympus",
            ReprocessingDeviceId = 12,
            ReprocessingDeviceLabel = "ETD Double",
            ReprocessingDeviceSerial = "12345",
            ReprocessingDeviceLocation = "Jaron",
            DepartmentName = "Jaron",
            ErrorNumber = 3057,
            ErrorDescription = "Pumpendruck für obere Ebene außerhalb des zulässigen Bereichs",
            BlockNumber = 2,
            StepNumber = 4930,
            ErrorTime = DateTime.Parse("2022-06-15T11:42:11Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            CabinetPosition = null,
        },
        // cycle 3125: ETD Double, clean success (single cycle-only row)
        new()
        {
            CycleId = 3125,
            StartedAt = DateTime.Parse("2022-06-16T08:01:00Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            FinishedAt = DateTime.Parse("2022-06-16T08:42:11Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            IsSuccess = true,
            ProgramName = "Ocean 3 Flex Standard Dauer cw",
            DeviceFamily = "etddouble",
            EndoscopeId = 8,
            EndoscopeSerial = "000074381007",
            EndoscopeTypeLabel = "GIF-1TQ160",
            EndoscopeManufacturer = "Olympus",
            ReprocessingDeviceId = 12,
            ReprocessingDeviceLabel = "ETD Double",
            ReprocessingDeviceSerial = "12345",
            ReprocessingDeviceLocation = "Jaron",
            DepartmentName = "Jaron",
        },
        // cycle 7011: EDC, one error with cabinet position
        new()
        {
            CycleId = 7011,
            StartedAt = DateTime.Parse("2022-08-01T09:15:00Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            FinishedAt = DateTime.Parse("2022-08-01T09:55:00Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            IsSuccess = false,
            ProgramName = null,
            DeviceFamily = "edc",
            EndoscopeId = 9,
            EndoscopeSerial = "000074381099",
            EndoscopeTypeLabel = "CF-Q150L",
            EndoscopeManufacturer = "Olympus",
            ReprocessingDeviceId = 42,
            ReprocessingDeviceLabel = "EDC Plus nr. 1",
            ReprocessingDeviceSerial = "EDC-1",
            ReprocessingDeviceLocation = "Jaron",
            DepartmentName = "Jaron",
            ErrorNumber = 12,
            ErrorDescription = null,
            ErrorTime = DateTime.Parse("2022-08-01T09:55:00Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            CabinetPosition = 3,
        },
        // cycle 9001: ETDv3, no error rows -> single cycle-only row
        new()
        {
            CycleId = 9001,
            StartedAt = DateTime.Parse("2022-09-10T07:00:00Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            FinishedAt = DateTime.Parse("2022-09-10T07:40:00Z", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal),
            IsSuccess = true,
            ProgramName = "WD thermal self disinfection",
            DeviceFamily = "etdv3",
            EndoscopeId = 11,
            EndoscopeSerial = "000074382000",
            EndoscopeTypeLabel = "BF-TE2",
            EndoscopeManufacturer = "Olympus",
            ReprocessingDeviceId = 27,
            ReprocessingDeviceLabel = "ETD v3",
            ReprocessingDeviceSerial = "27-A",
            ReprocessingDeviceLocation = "Endoscopy 2",
            DepartmentName = "Endoscopy 2",
        },
    };
}
