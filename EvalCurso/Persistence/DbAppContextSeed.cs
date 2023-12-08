using System.Globalization;
using System.Reflection;
using CsvHelper;
using CsvHelper.Configuration;
using Domain.Entities;
using Microsoft.Extensions.Logging;


namespace Persistence;
public class DbAppContextSeed
{
    public static async Task SeedAsync(DbAppContext context, ILoggerFactory loggerFactory)
    {
        try
        {
            //inicio de las insersiones en la db
            var ruta = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);


/*             if (!context.Users.Any())
            {
                using (var reader = new StreamReader(ruta + @"/Data/Csv/User.csv"))
                {
                    using (var csv = new CsvReader(reader, CultureInfo.InvariantCulture))
                    {
                        var list = csv.GetRecords<User>();
                        context.Users.AddRange(list);
                        await context.SaveChangesAsync();
                    }
                }
                
            } */

            if (!context.Users.Any())
            {
                using (var reader = new StreamReader(ruta + @"\Data\Csv\User.csv"))
                {
                    using (var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                    {
                        HeaderValidated = null, // Esto deshabilita la validación de encabezados
                        MissingFieldFound = null
                    }))
                    {
                        // Resto de tu código para leer y procesar el archivo CSV
                        var list = csv.GetRecords<User>();
                        List<User> entidad = new List<User>();
                        foreach (var item in list)
                        {
                            entidad.Add(new User
                            {
/*                                 Id = item.Id, */
                                Nombre = item.Nombre,
                                Email = item.Email,
                                Password = item.Password
                            });
                        }
                        context.Users.AddRange(entidad);
                        await context.SaveChangesAsync();
                    }
                }
            }

            if (!context.UserRoles.Any())
            {
                using (var reader = new StreamReader(ruta + @"\Data\Csv\RoleUser.csv"))
                {
                    using (var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                    {
                        HeaderValidated = null, // Esto deshabilita la validación de encabezados
                        MissingFieldFound = null
                    }))
                    {
                        // Resto de tu código para leer y procesar el archivo CSV
                        var list = csv.GetRecords<UserRol>();
                        List<UserRol> entidad = new List<UserRol>();
                        foreach (var item in list)
                        {
                            entidad.Add(new UserRol
                            {
                                UserIdFk = item.UserIdFk,
                                RolIdFk = item.RolIdFk
                            });
                        }
                        context.UserRoles.AddRange(entidad);
                        await context.SaveChangesAsync();
                    }
                }
            }
        //fin de las insersiones en la db
        }
        catch (Exception ex)
        {
            var logger = loggerFactory.CreateLogger<DbAppContext>();
            logger.LogError(ex.Message);
        }
    }
    public static async Task SeedRolesAsync(DbAppContext context, ILoggerFactory loggerFactory)
    {
        try
        {
            if (!context.Roles.Any())
            {
                var roles = new List<Rol>()
                        {
                            new Rol{ Nombre="Administrador"},
                            new Rol{ Nombre="Estudiante"},
                            new Rol{ Nombre="Profesor"}
                        };
                context.Roles.AddRange(roles);
                await context.SaveChangesAsync();
            }
        }
        catch (Exception ex)
        {
            var logger = loggerFactory.CreateLogger<DbAppContext>();
            logger.LogError(ex.Message);
        }
    }
}