# Reprocessings API

Minimal ASP.NET Core 8 implementation of the Reprocessings API spec v1
(`GET /api/reprocessings`).

This is intentionally a thin reference: the contract (query params, validation,
response envelope, snake_case row shape, sort order, limit clamp) is fully
implemented, but rows are served from a tiny in-memory sample set in
`SampleData.AllRows`. Replace that with a real Postgres query (per the
`hytrack-schema.sql` mapping in the spec) when wiring it up to data.

## Run

```bash
cd ReprocessingsApi
dotnet run
```

The API listens on `http://localhost:5270`.

## Quick examples

```bash
# All rows
curl -s http://localhost:5270/api/reprocessings | jq

# EndoscopeMonitoringETD-style query
curl -s "http://localhost:5270/api/reprocessings?deviceId=12&endoscopeId=8&from=2019-01-01T00:00:00Z&to=2022-07-01T00:00:00Z&limit=5000" | jq

# Single error code (per-error-row filter, v1 semantics)
curl -s "http://localhost:5270/api/reprocessings?deviceId=12&errorNumber=3057" | jq

# Only failed
curl -s "http://localhost:5270/api/reprocessings?deviceId=12&onlyFailed=true" | jq

# Bad params -> HTTP 400
curl -i "http://localhost:5270/api/reprocessings?from=not-a-date&deviceId=abc"
```

## What's implemented

- All query params: `from`, `to`, `deviceId`, `endoscopeId`, `errorNumber`,
  `onlyFailed`, `limit` (default 5000, clamped to `[1, 10000]`).
- Type validation -> HTTP 400 `{ "error": "invalid_params", "details": {...} }`.
- Unhandled exceptions -> HTTP 500 `{ "error": "internal_error", "message": "..." }`.
- `onlyFailed=true` excludes only clean successes (`is_success && errornumber IS NULL`).
- Sort: `started_at DESC, cycle_id ASC, blocknumber NULLS LAST, stepnumber NULLS LAST, errortime ASC NULLS LAST`.
- Response envelope `{ items, count, generatedAt, sourceUrl }` with `count == items.length`.
- `RowItem` JSON keys are snake_case; envelope keys are camelCase, exactly per spec.

## What's NOT implemented (deliberate)

- The actual SQL against the `hytrack` schema. Replace `SampleData.AllRows`
  with a real query (Dapper / EF Core / Npgsql) and apply the field-to-source
  mapping from the spec. The endpoint code does not need to change.
- Query timeout (the spec recommends 15s server-side; trivially added once a
  real DB call exists).
- Authentication / authorization.
- Path versioning (`/api/v2/reprocessings`) — only v1 is here.
