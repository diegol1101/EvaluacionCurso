using System.Reflection;
using API.Extensions;
using API.Helpers;
using AspNetCoreRateLimit;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Serilog;

var builder = WebApplication.CreateBuilder(args);
var logger = new LoggerConfiguration()
					.ReadFrom.Configuration(builder.Configuration)
					.Enrich.FromLogContext()
					.CreateLogger();

builder.Logging.AddSerilog(logger);


builder.Services.AddControllers();
builder.Services.AddAplicacionServices();
builder.Services.ConfigureRateLimiting();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAutoMapper(Assembly.GetEntryAssembly());
builder.Services.ConfigureCors();
builder.Services.AddAplicacionServices();
builder.Services.AddJwt(builder.Configuration);

builder.Services.AddDbContext<DbAppContext>(options =>
{
    string connectionString = builder.Configuration.GetConnectionString("ConexSqlServer");
    options.UseSqlServer(connectionString);
});

var app = builder.Build();
app.UseMiddleware<ExceptionMiddleware>();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var loggerFactory = services.GetRequiredService<ILoggerFactory>();
    try
    {
        var context = services.GetRequiredService<DbAppContext>();  
        await context.Database.MigrateAsync();
        await DbAppContextSeed.SeedRolesAsync(context,loggerFactory);
        await DbAppContextSeed.SeedAsync(context,loggerFactory);
    }
    catch (Exception ex)
    {
        var _logger = loggerFactory.CreateLogger<Program>();
        _logger.LogError(ex, "Ocurrió un error durante la migración");
    }
}

app.UseCors("CorsPolicy");

app.UseHttpsRedirection();

app.UseIpRateLimiting();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
