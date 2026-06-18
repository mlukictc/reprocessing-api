using Microsoft.EntityFrameworkCore;

namespace ReprocessingsApi.Data;

// Thin DbContext used only for opening Npgsql connections + running raw SQL via
// db.Database.SqlQueryRaw<T>(...). No entities are mapped — the schema lives in
// the existing hytrack database and is queried with hand-written SQL.
public sealed class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }
}
