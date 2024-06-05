@echo off
SETLOCAL EnableDelayedExpansion

cd %~dp0
set DIR_EJECUCION=%cd%

REM Obtén el nombre de la carpeta actual
for %%I in (%DIR_EJECUCION%) do set nombreCarpeta=%%~nxI

REM Inicializa una variable para el arreglo vacío
set misProyectos=""

echo Nota de Recomendacion:
echo - El nombre del proyecto no debe contener símbolos.
echo - Evite usar espacios en blanco.
echo - No incluir numeros.
echo.

REM Creación del proyecto WebApi
dotnet new sln
SET folderName=API

dotnet new webapi -o !folderName!


REM Cambiar el program
(
    echo using System.Reflection;
    echo using API.Extensions;
    echo using API.Helpers;
    echo using AspNetCoreRateLimit;
    echo using Microsoft.EntityFrameworkCore;
    echo using Persistencia;
    echo using Serilog;
    echo.
   

) > %DIR_EJECUCION%\%folderName%\Program.cs
(
    echo var builder = WebApplication.CreateBuilder^(args^);
    echo var logger = new LoggerConfiguration^(^)
    echo 					.ReadFrom.Configuration^(builder.Configuration^)
    echo 					.Enrich.FromLogContext^(^)
    echo 					.CreateLogger^(^);
    echo.
    echo //builder.Logging.ClearProviders^(^);
    echo builder.Logging.AddSerilog^(logger^);
    echo // Add services to the container.
    echo.
    
) >> %DIR_EJECUCION%\%folderName%\Program.cs
(

    echo builder.Services.AddControllers^(^);
    echo builder.Services.AddAplicacionServices^(^);
    echo builder.Services.ConfigureRateLimiting^(^);
    echo builder.Services.ConfigureApiVersioning^(^);
    echo // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
    echo builder.Services.AddEndpointsApiExplorer^(^);
    echo builder.Services.AddSwaggerGen^(^);
    echo builder.Services.AddAutoMapper^(Assembly.GetEntryAssembly^(^)^);
    echo builder.Services.ConfigureCors^(^);
    echo builder.Services.AddAplicacionServices^(^);
    echo builder.Services.AddJwt^(builder.Configuration^);
    echo.
    
) >> %DIR_EJECUCION%\%folderName%\Program.cs

(

    
    echo builder.Services.AddDbContext^<ApiContext^>^(options =^>
    echo ^{
    echo 	string connectionString = builder.Configuration.GetConnectionString^("ConexMysql"^);
    echo 	options.UseMySql^(connectionString, ServerVersion.AutoDetect^(connectionString^)^);
    echo ^}^);
    echo.
    echo var app = builder.Build^(^);
    echo app.UseMiddleware^<ExceptionMiddleware^>^(^);
    echo.
    echo // Configure the HTTP request pipeline.
    echo if ^(app.Environment.IsDevelopment^(^)^)
    echo ^{
    echo 	app.UseSwagger^(^);
    echo 	app.UseSwaggerUI^(^);
    echo ^}
    echo using ^(var scope = app.Services.CreateScope^(^)^)
    echo ^{
    echo 	var services = scope.ServiceProvider;
    echo 	var loggerFactory = services.GetRequiredService^<ILoggerFactory^>^(^);
    echo 	try
    echo 	^{
    echo 		var context = services.GetRequiredService^<ApiContext^>^(^);
    echo 		await context.Database.MigrateAsync^(^);

) >> %DIR_EJECUCION%\%folderName%\Program.cs
(
    echo 		await ApiContextSeed.SeedRolesAsync^(context,loggerFactory^);
    echo 		await ApiContextSeed.SeedAsync^(context,loggerFactory^);
    echo 	^}
    echo 	catch ^(Exception ex^)
    echo 	^{
    echo 		var _logger = loggerFactory.CreateLogger^<Program^>^(^);
    echo 		_logger.LogError^(ex, "Ocurrio un error durante la migracion"^);
    echo 	^}
    echo ^}
    echo.
    echo app.UseCors^("CorsPolicy"^);
    echo.
    echo app.UseHttpsRedirection^(^);
    echo.
    echo app.UseIpRateLimiting^(^);
    echo.
    echo app.UseAuthentication^(^);
    echo.
    echo app.UseAuthorization^(^);
    echo.
    echo app.MapControllers^(^);
    echo.
    echo app.Run^(^);

) >> %DIR_EJECUCION%\%folderName%\Program.cs
(
    echo ^{
    echo ^"Logging^": ^{
    echo   "LogLevel": ^{
    echo     "Default": "Information",
    echo     "Microsoft.AspNetCore": "Warning"
    echo    ^}
    echo ^},
    echo "JWT": ^{
    echo     "Key": "rgfZs3pNboV0hbG6Fat123123123sadasdasd",
    echo     "Issuer": "MyStoreApi",
    echo     "Audience": "MyStoreApiUser",
    echo     "DurationInMinutes":  1
    echo   ^},
    echo "AllowedHosts": "*",
    echo  "ConnectionStrings": ^{
    echo       "ConexSqlServer": "Data Source=localhost\\sqlexpress;Inital Catalog=Db;Integrate Security=true",
    echo       "ConexMySql": "Server=localhost;User=root;Database=NombreBD;Password=123456;"
    echo  ^}
    echo ^}
) > %DIR_EJECUCION%\%folderName%\appsettings.json

(
    echo ^{
    echo ^"Logging^": ^{
    echo   "LogLevel": ^{
    echo     "Default": "Information",
    echo     "Microsoft.AspNetCore": "Warning"
    echo    ^}
    echo ^},
    echo "JWT": ^{
    echo     "Key": "rgfZs3pNboV0hbG6Fat123123123sadasdasd",
    echo     "Issuer": "MyStoreApi",
    echo     "Audience": "MyStoreApiUser",
    echo     "DurationInMinutes":  1
    echo   ^},
    echo "AllowedHosts": "*",
    echo  "ConnectionStrings": ^{
    echo       "ConexSqlServer": "Data Source=localhost\\sqlexpress;Inital Catalog=Db;Integrate Security=true",
    echo       "ConexMySql": "Server=localhost;User=root;Database=NombreBD;Password=123456;"
    echo  ^}
    echo ^}
) > %DIR_EJECUCION%\%folderName%\appsettings.Development.json

dotnet add !folderName!\!folderName!.csproj package AspNetCoreRateLimit --version 5.0.0
dotnet add !folderName!\!folderName!.csproj package AutoMapper.Extensions.Microsoft.DependencyInjection --version 12.0.1
dotnet add !folderName!\!folderName!.csproj package Microsoft.AspNetCore.Authentication.JwtBearer --version 7.0.12
dotnet add !folderName!\!folderName!.csproj package Microsoft.AspNetCore.Mvc.Versioning --version 5.1.0
dotnet add !folderName!\!folderName!.csproj package Microsoft.AspNetCore.OpenApi --version 7.0.10
dotnet add !folderName!\!folderName!.csproj package Microsoft.EntityFrameworkCore.Design --version 7.0.12
dotnet add !folderName!\!folderName!.csproj package Serilog.AspNetCore --version 7.0.0
dotnet add !folderName!\!folderName!.csproj package Swashbuckle.AspNetCore --version 6.5.0
dotnet add !folderName!\!folderName!.csproj package System.IdentityModel.Tokens.Jwt --version 7.0.2
SET app=Aplicacion
dotnet new classlib -o !app!
SET persistencia=persistencia
dotnet new classlib -o !persistencia!
dotnet add !persistencia!\!persistencia!.csproj package Pomelo.EntityFrameworkCore.MySql --version 7.0.0
dotnet add !persistencia!\!persistencia!.csproj package Microsoft.EntityFrameworkCore --version 7.0.12
dotnet add !persistencia!\!persistencia!.csproj package CsvHelper --version 30.0.1
(
    echo using System.Reflection;
    echo using Dominio.Entities;
    echo using Microsoft.EntityFrameworkCore;
    echo.
    echo namespace Persistencia;
    echo public class ApiContext : DbContext
    echo ^{
    echo     public ApiContext^(DbContextOptions options^) : base^(options^)
    echo     ^{ ^}
    echo    public DbSet^<Rol^> Roles ^{ get; set; ^}
    echo    public DbSet^<RolUsuario^> RolUsuarios ^{ get; set; ^}
    echo    public DbSet^<Usuario^> Usuarios ^{ get; set; ^}
) > "%DIR_EJECUCION%\%persistencia%\ApiContext.cs"
(
    echo using System.Globalization;
    echo using System.Reflection;
    echo using CsvHelper;
    echo using CsvHelper.Configuration;
    echo using Dominio.Entities;
    echo using Microsoft.Extensions.Logging;
    echo.
    echo namespace Persistencia;
    echo public class ApiContextSeed
    echo ^{
    echo     public static async Task SeedAsync^(ApiContext context, ILoggerFactory loggerFactory^)
    echo     ^{
    echo         try
    echo         ^{
    echo             //inicio de las insersiones en la db
    echo             var ruta = Path.GetDirectoryName^(Assembly.GetExecutingAssembly^(^).Location^);
    echo.
    echo             if ^(!context.Usuarios.Any^(^)^)
    echo             ^{
    echo                 using ^(var reader = new StreamReader^(ruta + @"/Data/Csv/User.csv"^)^)
    echo                 ^{
    echo                     using ^(var csv = new CsvReader^(reader, CultureInfo.InvariantCulture^)^)
    echo                     ^{
    echo                         var list = csv.GetRecords^<Usuario^>^(^);
    echo                         context.Usuarios.AddRange^(list^);
    echo                         await context.SaveChangesAsync^(^);
    echo                     ^}
    echo                 ^}
    echo.             
    echo             ^}
    echo.
    echo             if ^(!context.RolUsuarios.Any^(^)^)
    echo             ^{
    echo                 using ^(var reader = new StreamReader^(ruta + @"\Data\Csv\RoleUser.csv"^)^)
    echo                 ^{
    echo                     using ^(var csv = new CsvReader^(reader, new CsvConfiguration^(CultureInfo.InvariantCulture^)
    echo                     ^{
    echo                         HeaderValidated = null, // Esto deshabilita la validación de encabezados
    echo                         MissingFieldFound = null
    echo                     ^}^)^)
    echo                     ^{
    echo                         // Resto de tu código para leer y procesar el archivo CSV
    echo                         var list = csv.GetRecords^<RolUsuario^>^(^);
    echo                         List^<RolUsuario^> entidad = new List^<RolUsuario^>^(^);
    echo                         foreach ^(var item in list^)
    echo                         ^{
    echo                             entidad.Add^(new RolUsuario
    echo                             ^{
    echo                                 IdUsuarioFk = item.IdUsuarioFk,
    echo                                 IdRolFk = item.IdRolFk
    echo                             ^}^);
    echo                         ^}
    echo                         context.RolUsuarios.AddRange^(entidad^);
    echo                         await context.SaveChangesAsync^(^);
    echo                     ^}
    echo                 ^}
    echo             ^}
    echo         //fin de las insersiones en la db
    echo         ^}
    echo         catch ^(Exception ex^)
    echo         ^{
    echo             var logger = loggerFactory.CreateLogger^<ApiContext^>(^);
    echo             logger.LogError^(ex.Message^);
    echo         ^}
    echo     ^}
    echo     public static async Task SeedRolesAsync^(ApiContext context, ILoggerFactory loggerFactory^)
    echo     ^{
    echo         try
    echo         ^{
    echo             if ^(!context.Roles.Any^(^)^)
    echo             ^{
    echo                 var roles = new List^<Rol^>^(^)
    echo                         ^{
    echo                             new Rol^{Id=1, Nombre="Administrador"^},
    echo                             new Rol^{Id=2, Nombre="Empleado"^},
    echo                         };
    echo                 context.Roles.AddRange^(roles^);
    echo                 await context.SaveChangesAsync^(^);
    echo             ^}
    echo         ^}
    echo         catch ^(Exception ex^)
    echo         ^{
    echo             var logger = loggerFactory.CreateLogger^<ApiContext^>^(^);
    echo             logger.LogError^(ex.Message^);
    echo         ^}
    echo     ^}
    echo ^}

) > "%DIR_EJECUCION%\%persistencia%\ApiContextSeed.cs"
SET dom=Dominio
dotnet new classlib -o !dom!
dotnet add !dom!\!dom!.csproj package FluentValidation.AspNetCore --version 11.3.0
dotnet add !dom!\!dom!.csproj package itext7.pdfhtml --version 5.0.1
dotnet add !dom!\!dom!.csproj package Microsoft.EntityFrameworkCore --version 7.0.12
REM Agregando proyectos a la solucion
echo %DIR_EJECUCION%

dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %folderName%\%folderName%.csproj
dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %app%\%app%.csproj
dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %dom%\%dom%.csproj
dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %persistencia%\%persistencia%.csproj
REM Agregando referencias entre proyectos
echo %DIR_EJECUCION%\%app%

cd %DIR_EJECUCION%\%app%
dotnet add reference %DIR_EJECUCION%\%dom%\%dom%.csproj
dotnet add reference %DIR_EJECUCION%\%persistencia%\%persistencia%.csproj
cd %DIR_EJECUCION%\%folderName%
dotnet add reference %DIR_EJECUCION%\%app%\%app%.csproj
cd %DIR_EJECUCION%\%persistencia%
dotnet add reference %DIR_EJECUCION%\%dom%\%dom%.csproj

REM Creación de carpetas correspondientes al segundo menu
mkdir %DIR_EJECUCION%\%folderName%\Services
(
    echo using API.Dtos;
    echo using Dominio.Entities;
    echo.
    echo namespace API.Services;
    echo public interface IUserService
    echo ^{
    echo     Task^<string^> RegisterAsync^(RegisterDto model^);
    echo     Task^<DataUserDto^> GetTokenAsync^(LoginDto model^);
    echo     Task^<string^> AddRoleAsync^(AddRoleDto model^);
    echo     Task^<DataUserDto^> RefreshTokenAsync^(string refreshToken^);
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Services\IUserService.cs"

(
    echo using System.IdentityModel.Tokens.Jwt;
    echo using System.Security.Claims;
    echo using System.Security.Cryptography;
    echo using System.Text;
    echo using API.Dtos;
    echo using API.Helpers;
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.AspNetCore.Identity;
    echo using Microsoft.Extensions.Options;
    echo using Microsoft.IdentityModel.Tokens;

    echo namespace API.Services;
    echo public class UserService : IUserService
    echo ^{
    echo     private readonly JWT _jwt;
    echo     private readonly IUnitOfWork _unitOfWork;
    echo     private readonly IPasswordHasher^<Usuario^> _passwordHasher;
    echo     public UserService^(IUnitOfWork unitOfWork, IOptions^<JWT^> jwt, IPasswordHasher^<Usuario^> passwordHasher^)
    echo     ^{
    echo         _jwt = jwt.Value;
    echo         _unitOfWork = unitOfWork;
    echo         _passwordHasher = passwordHasher;
    echo     ^}
    echo     public async Task^<string^> RegisterAsync^(RegisterDto registerDto^)
    echo     ^{
    echo         var user = new Usuario
    echo         ^{
    echo             Nombre = registerDto.Nombre,
    echo             Email = registerDto.Email
    echo         ^};

    echo         user.Password = _passwordHasher.HashPassword^(user, registerDto.Password^); //Encrypt password

    echo         var existingUser = _unitOfWork.Usuarios
    echo                                     .Find^(u =^> u.Nombre.ToLower^(^) == registerDto.Nombre.ToLower^(^)^)
    echo                                     .FirstOrDefault^(^);

    echo         if ^(existingUser == null^)
    echo         ^{
    echo             var rolDefault = _unitOfWork.Roles
    echo                                     .Find^(u =^> u.Nombre == Authorization.rol_default.ToString^(^)^)
    echo                                     .First^(^);
    echo             try
    echo             ^{
    echo                 user.Rols.Add^(rolDefault^);
    echo                 _unitOfWork.Usuarios.Add^(user^);
    echo                 await _unitOfWork.SaveAsync^(^);

    echo                 return $"User  {registerDto.Nombre} has been registered successfully";
    echo             ^}
    echo             catch ^(Exception ex^)
    echo             ^{
    echo                 var message = ex.Message;
    echo                 return $"Error: {message}";
    echo             ^}
    echo         ^}
    echo         else
    echo         ^{
    echo             return $"User {registerDto.Nombre} already registered.";
    echo         ^}
    echo     ^}
    echo     public async Task^<DataUserDto^> GetTokenAsync^(LoginDto model^)
    echo     ^{
    echo         DataUserDto dataUserDto = new DataUserDto^(^);
    echo         var user = await _unitOfWork.Usuarios
    echo                     .GetByUsernameAsync^(model.Nombre^);

    echo         if ^(user == null^)
    echo         ^{
    echo             dataUserDto.IsAuthenticated = false;
    echo             dataUserDto.Message = $"User does not exist with username {model.Nombre}.";
    echo             return dataUserDto;
    echo         ^}

    echo         var result = _passwordHasher.VerifyHashedPassword^(user, user.Password, model.Password^);

    echo         if ^(result == PasswordVerificationResult.Success^)
    echo         ^{
    echo             dataUserDto.IsAuthenticated = true;
    echo             JwtSecurityToken jwtSecurityToken = CreateJwtToken^(user^);
    echo             dataUserDto.Token = new JwtSecurityTokenHandler^(^).WriteToken^(jwtSecurityToken^);
    echo             dataUserDto.UserName = user.Nombre;
    echo             dataUserDto.Roles = user.Rols
    echo                                             .Select^(u =^> u.Nombre^)
    echo                                             .ToList^(^);

    echo             if ^(user.RefreshTokens.Any^(a =^> a.IsActive^)^)
    echo             ^{
    echo                 var activeRefreshToken = user.RefreshTokens.Where^(a =^> a.IsActive == true^).FirstOrDefault^(^);
    echo                 dataUserDto.RefreshToken = activeRefreshToken.Token;
    echo                 dataUserDto.RefreshTokenExpiration = activeRefreshToken.Expires;
    echo             ^}
    echo             else
    echo             ^{
    echo                 var refreshToken = CreateRefreshToken^(^);
    echo                 dataUserDto.RefreshToken = refreshToken.Token;
    echo                 dataUserDto.RefreshTokenExpiration = refreshToken.Expires;
    echo                 user.RefreshTokens.Add^(refreshToken^);
    echo                 _unitOfWork.Usuarios.Update^(user^);
    echo                 await _unitOfWork.SaveAsync^(^);
    echo             ^}

    echo             return dataUserDto;
    echo         ^}
    echo         dataUserDto.IsAuthenticated = false;
    echo         dataUserDto.Message = $"Credenciales incorrectas para el usuario ^{user.Nombre}.";
    echo         return dataUserDto;
    echo     ^}
    echo     public async Task^<string^> AddRoleAsync^(AddRoleDto model^)
    echo     ^{

    echo         var user = await _unitOfWork.Usuarios
    echo                     .GetByUsernameAsync^(model.Nombre^);
    echo         if ^(user == null^)
    echo         ^{
    echo             return $"User {model.Nombre} does not exists.";
    echo         ^}

    echo         var result = _passwordHasher.VerifyHashedPassword^(user, user.Password, model.Password^);

    echo         if ^(result == PasswordVerificationResult.Success^)
    echo         ^{
    echo             var rolExists = _unitOfWork.Roles
    echo                                         .Find^(u =^> u.Nombre.ToLower^(^) == model.Role.ToLower^(^)^)
    echo                                         .FirstOrDefault^(^);

    echo             if ^(rolExists ^!= null^)
    echo             ^{
    echo                 var userHasRole = user.Rols.Any^(u =^> u.Id == rolExists.Id^);

    echo                 if ^(userHasRole == false^)
    echo                 ^{
    echo                     user.Rols.Add^(rolExists^);
    echo                     _unitOfWork.Usuarios.Update^(user^);
    echo                     await _unitOfWork.SaveAsync^(^);
    echo                 ^}

    echo                 return $"Role {model.Role} added to user {model.Nombre} successfully.";
    echo             ^}

    echo             return $"Role {model.Role} was not found.";
    echo         ^}
    echo         return $"Invalid Credentials";
    echo     ^}
    echo     public async Task^<DataUserDto^> RefreshTokenAsync^(string refreshToken^)
    echo     ^{
    echo         var dataUserDto = new DataUserDto^(^);

    echo         var usuario = await _unitOfWork.Usuarios
    echo                         .GetByRefreshTokenAsync^(refreshToken^);

    echo         if ^(usuario == null^)
    echo         ^{
    echo             dataUserDto.IsAuthenticated = false;
    echo             dataUserDto.Message = $"Token is not assigned to any user.";
    echo             return dataUserDto;
    echo         ^}

    echo         var refreshTokenBd = usuario.RefreshTokens.Single^(x =^> x.Token == refreshToken^);

    echo         if ^(!refreshTokenBd.IsActive^)
    echo         ^{
    echo             dataUserDto.IsAuthenticated = false;
    echo             dataUserDto.Message = $"Token is not active.";
    echo             return dataUserDto;
    echo         ^}
    echo         //Revoque the current refresh token and
    echo         refreshTokenBd.Revoked = DateTime.UtcNow;
    echo         //generate a new refresh token and save it in the database
    echo         var newRefreshToken = CreateRefreshToken^(^);
    echo         usuario.RefreshTokens.Add^(newRefreshToken^);
    echo         _unitOfWork.Usuarios.Update^(usuario^);
    echo         await _unitOfWork.SaveAsync^(^);
    echo         //Generate a new Json Web Token
    echo         dataUserDto.IsAuthenticated = true;
    echo         JwtSecurityToken jwtSecurityToken = CreateJwtToken^(usuario^);
    echo         dataUserDto.Token = new JwtSecurityTokenHandler^(^).WriteToken^(jwtSecurityToken^);
    echo         /*         dataUserDto.Email = usuario.Email;
    echo          */
    echo         dataUserDto.UserName = usuario.Nombre;
    echo         dataUserDto.Email = usuario.Email;
    echo         dataUserDto.Roles = usuario.Rols
    echo                                         .Select^(u =^> u.Nombre^)
    echo                                         .ToList^(^);
    echo         dataUserDto.RefreshToken = newRefreshToken.Token;
    echo         dataUserDto.RefreshTokenExpiration = newRefreshToken.Expires;
    echo         return dataUserDto;
    echo     ^}
    echo     private RefreshToken CreateRefreshToken^(^)
    echo     ^{
    echo         var randomNumber = new byte^[32^];
    echo         using ^(var generator = RandomNumberGenerator.Create^(^)^)
    echo         ^{
    echo             generator.GetBytes^(randomNumber^);
    echo             return new RefreshToken
    echo             ^{
    echo                 Token = Convert.ToBase64String^(randomNumber^),
    echo                 Expires = DateTime.UtcNow.AddDays^(10^),
    echo                 Created = DateTime.UtcNow
    echo             ^};
    echo         ^}
    echo     ^}
    echo     private JwtSecurityToken CreateJwtToken^(Usuario usuario^)
    echo     ^{
    echo         var roles = usuario.Rols;
    echo         var roleClaims = new List^<Claim^>^(^);
    echo         foreach ^(var role in roles^)
    echo         ^{
    echo             roleClaims.Add^(new Claim^("roles", role.Nombre^)^);
    echo         ^}
    echo         var claims = new^[^]
    echo         ^{
    echo                                 new Claim^(JwtRegisteredClaimNames.Sub, usuario.Nombre^),
    echo                                 new Claim^(JwtRegisteredClaimNames.Jti, Guid.NewGuid^(^).ToString^(^)^),
    echo                                 new Claim^(JwtRegisteredClaimNames.Email, usuario.Email^),
    echo                                 new Claim^("uid", usuario.Id.ToString^(^)^)
    echo                         ^}
    echo         .Union^(roleClaims^);
    echo         var symmetricSecurityKey = new SymmetricSecurityKey^(Encoding.UTF8.GetBytes^(_jwt.Key^)^);
    echo         var signingCredentials = new SigningCredentials^(symmetricSecurityKey, SecurityAlgorithms.HmacSha256^);
    echo         var jwtSecurityToken = new JwtSecurityToken^(
    echo             issuer: _jwt.Issuer,
    echo             audience: _jwt.Audience,
    echo             claims: claims,
    echo             expires: DateTime.UtcNow.AddMinutes^(_jwt.DurationInMinutes^),
    echo             signingCredentials: signingCredentials^);
    echo         return jwtSecurityToken;
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%folderName%\Services\UserService.cs"

mkdir %DIR_EJECUCION%\%folderName%\Helpers
(
    echo namespace API.Helpers;
    echo.
    echo public class ApiException : ApiResponse
    echo ^{
    echo     public ApiException^(int statusCode, string message = null, string details = null^)
    echo                     : base^(statusCode, message^)
    echo     ^{
    echo         Details = details;
    echo     ^}
    echo.
    echo     public string Details ^{ get; set; ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Helpers\ApiException.cs"

(
    echo namespace API.Helpers;
    echo.
    echo public class ApiResponse
    echo ^{
    echo     public int StatusCode ^{ get; set; ^}
    echo     public string Message ^{ get; set; ^}
    echo.
    echo     public ApiResponse^(int statusCode, string message = null^)
    echo     ^{
    echo         StatusCode = statusCode;
    echo         Message = message ?? GetDefaultMessage^(statusCode^);
    echo     ^}
    echo.
    echo     public ApiResponse^(^)
    echo     ^{
    echo     ^}
    echo.
    echo     private string GetDefaultMessage^(int statusCode^)
    echo     ^{
    echo         return statusCode switch
    echo         ^{
    echo             400 =^> "Has realizado una petición incorrecta.",
    echo             401 =^> "Usuario no autorizado.",
    echo             404 =^> "El recurso que has intentado solicitar no existe.",
    echo             405 =^> "Este método HTTP no estapermitido en el servidor.",
    echo             500 =^> "Error en el servidor. No eres tu, soy yo. Comunícate con el administrador XD.",
    echo             _ =^> throw new NotImplementedException^(^)
    echo         ^};
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%folderName%\Helpers\ApiResponse.cs"

(
    echo namespace API.Helpers;
    echo.
    echo public class Authorization
    echo ^{
    echo     public enum Roles
    echo     ^{
    echo         Administrator,
    echo         Empleado,
    echo.
    echo     ^}
    echo     public const Roles rol_default = Roles.Empleado;
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Helpers\Authorization.cs"

(
    echo using System.Net;
    echo using System.Text.Json;
    echo.
    echo namespace API.Helpers;
    echo.
    echo public class ExceptionMiddleware
    echo ^{
    echo     private readonly RequestDelegate _next;
    echo     private readonly ILogger^<ExceptionMiddleware^> _logger;
    echo     private readonly IHostEnvironment _env;
    echo.
    echo     public ExceptionMiddleware^(RequestDelegate next,
    echo         ILogger^<ExceptionMiddleware^> logger, IHostEnvironment env^)
    echo     ^{
    echo         _next = next;
    echo         _logger = logger;
    echo         _env = env;
    echo     ^}
    echo.
    echo     public async Task InvokeAsync^(HttpContext context^)
    echo     ^{
    echo         try
    echo         ^{
    echo             await _next^(context^);
    echo         ^}
    echo         catch ^(Exception ex^)
    echo         ^{
    echo             var statusCode = ^(int^)HttpStatusCode.InternalServerError;
    echo.
    echo             _logger.LogError^(ex, ex.Message^);
    echo             context.Response.ContentType = "application/json";
    echo             context.Response.StatusCode = statusCode;
    echo.
    echo             var response = _env.IsDevelopment^(^)
    echo                             ? new ApiException^(statusCode, ex.Message, ex.StackTrace.ToString^(^)^)
    echo                             : new ApiException^(statusCode^);
    echo.
    echo             var options = new JsonSerializerOptions
    echo             ^{
    echo                 PropertyNamingPolicy = JsonNamingPolicy.CamelCase
    echo             ^};
    echo             var json = JsonSerializer.Serialize^(response, options^);
    echo.
    echo             await context.Response.WriteAsync^(json^);
    echo.
    echo         ^}
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%folderName%\Helpers\ExceptionMiddleware.cs"

(
    echo namespace API.Helpers;
    echo.
    echo public class JWT
    echo ^{
    echo     public string Key ^{ get; set; ^}
    echo     public string Issuer ^{ get; set; ^}
    echo     public string Audience ^{ get; set; ^}
    echo     public double DurationInMinutes^ { get; set; ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Helpers\JWT.cs"

(
    echo namespace API.Helpers.Errors;
    echo public class Pager^<T^> where T : class
    echo ^{
    echo     public string Search ^{ get; set; ^}
    echo     public int PageIndex ^{ get; set;^}
    echo     public int PageSize ^{ get; set;^}
    echo     public int Total ^{ get; set; ^}
    echo     public List^<T^> Registers ^{ get; set; ^}
    echo.
    echo     public Pager^(^)
    echo     ^{
    echo     ^}
    echo.
    echo     public Pager^(List^<T^> registers, int total, int pageIndex, int pageSize, string search^) 
    echo     ^{
    echo         Registers = registers;
    echo         Total = total;
    echo         PageIndex = pageIndex;
    echo         PageSize = pageSize;
    echo         Search = search; 
    echo     ^}
    echo.
    echo     public int TotalPages
    echo     ^{
    echo         get
    echo         ^{
    echo             return ^(int^)Math.Ceiling^(Total / ^(double^)PageSize^);
    echo         ^}
    echo         set
    echo         ^{
    echo             this.TotalPages = value;
    echo         ^}
    echo     ^}
    echo.
    echo     public bool HasPreviousPage
    echo     ^{
    echo         get
    echo         ^{
    echo             return ^(PageIndex ^> 1^);
    echo         ^}
    echo         set
    echo         ^{
    echo             this.HasPreviousPage = value;
    echo         ^}
    echo     ^}
    echo     public bool HasNextPage
    echo     ^{
    echo         get
    echo         ^{
    echo             return^( PageIndex ^< TotalPages^);
    echo         ^}
    echo         set
    echo         ^{
    echo             this.HasNextPage = value;
    echo         ^}
    echo     ^}
    echo.
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Helpers\Pager.cs"

(
    echo namespace API.Helpers.Errors;
    echo public class Params 
    echo ^{
    echo     private int _pageSize =5;
    echo     private const int MaxPageSize = 50;
    echo     private int _pageIndex = 1;
    echo     private string _search;
    echo.    
    echo     public int PageSize
    echo     ^{
    echo         get =^> _pageSize;
    echo         set =^> _pageSize = ^(value ^> MaxPageSize^) ? MaxPageSize : value;
    echo     ^}
    echo.
    echo     public int PageIndex
    echo     ^{
    echo         get =^> _pageIndex;
    echo         set =^> _pageIndex = ^(value ^<= 0^) ? 0 : value;
    echo     ^}
    echo     public string Search
    echo     ^{
    echo         get =^> _search;
    echo         set =^> _search = ^(^!string.IsNullOrEmpty^(value^)^)? value.ToLower^(^): "";
    echo     ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Helpers\Params.cs"

mkdir %DIR_EJECUCION%\%folderName%\Extensions
(
    echo using System.Text;
    echo using API.Helpers;
    echo using API.Services;
    echo using Aplicacion.UnitOfWork;
    echo using AspNetCoreRateLimit;
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.AspNetCore.Authentication.JwtBearer;
    echo using Microsoft.AspNetCore.Identity;
    echo using Microsoft.AspNetCore.Mvc;
    echo using Microsoft.AspNetCore.Mvc.Versioning;
    echo using Microsoft.IdentityModel.Tokens;
    echo.
    echo namespace API.Extensions;
    echo public static class ApplicationServiceExtension 
    echo ^{
    echo     public static void ConfigureCors^(this IServiceCollection services^) =^>
    echo             services.AddCors^(options =^>
    echo             ^{
    echo                 options.AddPolicy^("CorsPolicy", builder =^>
    echo                     builder.AllowAnyOrigin^(^)    //WithOrigins^("https://domain.com"^)
    echo                         .AllowAnyMethod^(^)       //WithMethods^("GET","POST^)
    echo                         .AllowAnyHeader^(^)^);     //WithHeaders^("accept","content-type"^)
    echo             }^);
    echo.
    echo     public static void AddAplicacionServices^(this IServiceCollection services^)
    echo         ^{
    echo             services.AddScoped^<IPasswordHasher^<Usuario^>, PasswordHasher^<Usuario^>^>^(^);
    echo             services.AddScoped^<IUserService, UserService^>^(^); 
    echo             services.AddScoped^<IUnitOfWork, UnitOfWork^>^(^);
    echo         ^}
    echo.
    echo public static void ConfigureApiVersioning^(this IServiceCollection services^)
    echo     ^{
    echo         services.AddApiVersioning^(options =^>
    echo         ^{
    echo             options.DefaultApiVersion = new ApiVersion^(1, 0^);
    echo             options.AssumeDefaultVersionWhenUnspecified = true;
    echo             //Para una versión 
    echo             //options.ApiVersionReader = new QueryStringApiVersionReader^("ver"^);
    echo.
    echo             //Para ambas versiones
    echo             options.ApiVersionReader = ApiVersionReader.Combine^(
    echo                 new QueryStringApiVersionReader^("ver"^),
    echo                 new HeaderApiVersionReader ^("X-Version"^)
    echo             ^);
    echo         ^}^);
    echo     ^}
    echo.
    echo     public static void ConfigureRateLimiting^(this IServiceCollection services^)
    echo         ^{
    echo             services.AddMemoryCache^(^);
    echo             services.AddSingleton^<IRateLimitConfiguration, RateLimitConfiguration^>^(^);
    echo             services.AddInMemoryRateLimiting^(^);
    echo             services.Configure^<IpRateLimitOptions^>^(options =^>
    echo             ^{
    echo                 options.EnableEndpointRateLimiting = true;
    echo                 options.StackBlockedRequests = true;
    echo                 options.HttpStatusCode =429;
    echo                 options.RealIpHeader = "X-real-ip";
    echo                 options.GeneralRules = new List^<RateLimitRule^>
    echo                 ^{
    echo                     new RateLimitRule
    echo                     ^{
    echo                         Endpoint = "*",
    echo                         Period = "10s",
    echo                         Limit = 15
    echo                     ^}
    echo                 ^};
    echo             ^}^);
    echo         ^}
    echo.
    echo     public static void AddJwt^(this IServiceCollection services, IConfiguration configuration^)
    echo         ^{
    echo             //Configuration from AppSettings
    echo             services.Configure^<JWT^>^(configuration.GetSection^("JWT"^)^);
    echo.
    echo             //Adding Athentication - JWT
    echo             services.AddAuthentication^(options =^>
    echo             ^{
    echo                 options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    echo                 options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    echo             ^}^)
    echo                 .AddJwtBearer^(o =^>
    echo                 ^{
    echo                     o.RequireHttpsMetadata = false;
    echo                     o.SaveToken = false;
    echo                     o.TokenValidationParameters = new TokenValidationParameters
    echo                     ^{
    echo                         ValidateIssuerSigningKey = true,
    echo                         ValidateIssuer = true,
    echo                         ValidateAudience = true,
    echo                         ValidateLifetime = true,
    echo                         ClockSkew = TimeSpan.Zero,
    echo                         ValidIssuer = configuration^["JWT:Issuer"^],
    echo                         ValidAudience = configuration^["JWT:Audience"^],
    echo                         IssuerSigningKey = new SymmetricSecurityKey^(Encoding.UTF8.GetBytes^(configuration^["JWT:Key"^]^)^)
    echo                     ^};
    echo                 ^}^);
    echo         ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Extensions\ApplicationServiceExtension.cs"
mkdir %DIR_EJECUCION%\%folderName%\Dtos
(
    echo using System.ComponentModel.DataAnnotations;
    echo.
    echo namespace API.Dtos;
    echo public class AddRoleDto
    echo ^{
    echo     ^[Required^]
    echo     public string Nombre ^{ get; set; ^}
    echo     ^[Required^]
    echo     public string Password ^{ get; set; ^}
    echo     ^[Required^]
    echo     public string Role ^{ get; set; ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Dtos\AddRoleDto.cs"

(
    echo using System.Text.Json.Serialization;
    echo.
    echo namespace API.Dtos;
    echo public class DataUserDto
    echo ^{
    echo     public int Id ^{ get; set; ^}
    echo     public string Message ^{ get; set; ^}
    echo     public bool IsAuthenticated ^{ get; set; ^}
    echo     public string UserName ^{ get; set; ^}
    echo     public string Email ^{ get; set; ^}
    echo     public List^<string^> Roles ^{ get; set; ^}
    echo     public string Token ^{ get; set; ^}
    echo.
    echo     ^[JsonIgnore^] // -^>this attribute restricts the property to be shown in the result
    echo     public string RefreshToken ^{ get; set; ^}
    echo     public DateTime RefreshTokenExpiration ^{ get; set; ^}        
    echo ^}
) > "%DIR_EJECUCION%\%folderName%\Dtos\DataUserDto.cs"

(
    echo using System.ComponentModel.DataAnnotations;
    echo.
    echo namespace API.Dtos;
    echo public class LoginDto
    echo ^{
    echo     ^[Required^]
    echo     public string Nombre ^{ get; set; ^}
    echo     ^[Required^]
    echo     public string Password ^{ get; set; ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Dtos\LoginDto.cs"

(
    echo using System.ComponentModel.DataAnnotations;
    echo.
    echo namespace API.Dtos;
    echo public class RegisterDto
    echo ^{
    echo     ^[Required^]
    echo     public string Nombre ^{ get; set; ^}
    echo     ^[Required^]
    echo     public string Password ^{ get; set; ^}
    echo     ^[Required^]
    echo     public string Email ^{ get; set; ^}
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Dtos\RegisterDto.cs"

(
    echo namespace API.Dtos;
    echo public class RolDto
    echo ^{
    echo     public int Id ^{ get; set;^}
    echo     public string Nombre ^{ get; set; ^}
    echo.
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Dtos\RolDto.cs"

(
    echo namespace API.Dtos;
    echo public class UsuarioDto
    echo ^{
    echo     public string Nombre ^{ get; set; ^}
    echo     public string Email ^{ get; set; ^}
    echo     public string Password ^{ get; set; ^}  
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Dtos\UsuarioDto.cs"

mkdir %DIR_EJECUCION%\%folderName%\Profiles
(
    echo using API.Dtos;
    echo using AutoMapper;
    echo using Dominio.Entities;

    echo namespace API.Profiles;
    echo public class MappingProfiles : Profile
    echo ^{
    echo     public MappingProfiles^(^)
    echo     ^{ 
    echo        CreateMap^<Rol,RolDto^>^(^).ReverseMap^(^);
    echo        CreateMap^<Usuario,UsuarioDto^>^(^).ReverseMap^(^);
) > "%DIR_EJECUCION%\%folderName%\Profiles\MappingProfiles.cs"

mkdir %DIR_EJECUCION%\%app%\Repository
(
    echo using System.Linq.Expressions;
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.EntityFrameworkCore;
    echo using Persistencia;
    echo namespace Aplicacion.Repository^;
    echo public class GenericRepo ^<T^> : IGenericRepo^<T^> where T : BaseEntity
    echo ^{
    echo     private readonly ApiContext _context;
    echo     public GenericRepo ^(ApiContext context^)
    echo     ^{
    echo         _context = context;
    echo     ^}
    echo     public virtual void Add ^(T entity^)
    echo     ^{
    echo         _context.Set^<T^>^(^).Add^(entity^);
    echo     ^}
    echo     public virtual void AddRange ^(IEnumerable^<T^> entities^)
    echo     ^{
    echo         _context.Set^<T^>^(^).AddRange^(entities^);
    echo     ^}
    echo     public virtual IEnumerable^<T^> Find ^(Expression^<Func^<T, bool^>^> expression^)
    echo     ^{
    echo         return _context.Set^<T^>^(^).Where^(expression^);
    echo     ^}
    echo     public virtual async Task^<IEnumerable^<T^>^> GetAllAsync^(^)
    echo     ^{
    echo         return await _context.Set^<T^>^(^).ToListAsync^(^);
    echo     ^}
    echo     public virtual async Task^<T^> GetByIdAsync ^(int id^)
    echo     ^{
    echo         return await _context.Set^<T^>^(^).FindAsync^(id^);
    echo     ^}
    echo     public virtual Task^<T^> GetByIdAsync ^(string id^)
    echo     ^{
    echo         throw new NotImplementedException^(^);
    echo     ^}
    echo     public virtual void Remove ^(T entity^)
    echo     ^{
    echo         _context.Set^<T^>^(^).Remove^(entity^);
    echo     ^}
    echo     public virtual void RemoveRange ^(IEnumerable^<T^> entities^)
    echo     ^{
    echo         _context.Set^<T^>^(^).RemoveRange^(entities^);
    echo     ^}
    echo     public virtual void Update ^(T entity^)
    echo     ^{
    echo         _context.Set^<T^>^(^)
    echo             .Update^(entity^);
    echo     ^}
    echo     public virtual async Task^<^(int totalRegistros, IEnumerable^<T^> registros^)^> GetAllAsync ^(int pageIndex, int pageSize, string _search^)
    echo     ^{
    echo         var totalRegistros = await _context.Set^<T^>^(^).CountAsync^(^);
    echo         var registros = await _context.Set^<T^>^(^)
    echo             .Skip^(^(pageIndex - 1^) * pageSize^)
    echo             .Take^(pageSize^)
    echo             .ToListAsync^(^);
    echo         return ^(totalRegistros, registros^);
    echo     ^}
    echo     public virtual async Task^<^(int totalRegistros, IEnumerable^<T^> registros^)^> GetAllAsync ^(int pageIndex, int pageSize, int _search^)
    echo     ^{
    echo         var totalRegistros = await _context.Set^<T^>^(^).CountAsync^(^);
    echo         var registros = await _context.Set^<T^>^(^)
    echo             .Skip^(^(pageIndex - 1^) * pageSize^)
    echo             .Take^(pageSize^)
    echo             .ToListAsync^(^);
    echo         return ^(totalRegistros, registros^);
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%app%\Repository\GenericRepo.cs"

(
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.EntityFrameworkCore;
    echo using Persistencia;
    echo.
    echo namespace Aplicacion.Repository;
    echo public class RolRepository : GenericRepo^<Rol^>, IRol
    echo ^{
    echo     private readonly ApiContext _context;
    echo.  
    echo     public RolRepository^(ApiContext context^) : base^(context^)
    echo     ^{
    echo     _context = context;
    echo     ^}
    echo     public override async Task^<IEnumerable^<Rol^>^> GetAllAsync^(^)
    echo     ^{
    echo         return await _context.Roles
    echo             .ToListAsync^(^);
    echo     ^}
    echo.
    echo     public override async Task^<Rol^> GetByIdAsync^(int id^)
    echo     ^{
    echo         return await _context.Roles
    echo         .FirstOrDefaultAsync^(p =^>  p.Id == id^);
    echo     ^}
    echo     public override async Task^<^(int totalRegistros, IEnumerable^<Rol^> registros^)^> GetAllAsync^(int pageIndez, int pageSize, string search^)
    echo     ^{
    echo         var query = _context.Roles as IQueryable^<Rol^>;
    echo.
    echo         if^(!string.IsNullOrEmpty^(search^)^)
    echo         ^{
    echo             query = query.Where^(p =^> p.Nombre.ToLower^(^).Contains^(search^)^);
    echo         ^}
    echo.
    echo         query = query.OrderBy^(p =^> p.Id^);
    echo         var totalRegistros = await query.CountAsync^(^);
    echo         var registros = await query 
    echo             .Skip^(^(pageIndez - 1^) * pageSize^)
    echo             .Take^(pageSize^)
    echo             .ToListAsync^(^);
    echo.
    echo         return ^(totalRegistros, registros^);
    echo     ^}
    echo }
) > "%DIR_EJECUCION%\%app%\Repository\RolRepository.cs"

(
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.EntityFrameworkCore;
    echo using Persistencia;
    echo.
    echo namespace Aplicacion.Repository;
    echo public class UsuarioRepository : GenericRepo^<Usuario^>, IUsuario
    echo ^{
    echo     private readonly ApiContext _context;
    echo.
    echo     public UsuarioRepository^(ApiContext context^) : base^(context^)
    echo     ^{
    echo         _context = context;
    echo     ^}
    echo.
    echo     public async Task^<Usuario^> GetByRefreshTokenAsync^(string refreshToken^)
    echo     ^{
    echo         return await _context.Usuarios
    echo             .Include^(u =^> u.Rols^)
    echo             .Include^(u =^> u.RefreshTokens^)
    echo             .FirstOrDefaultAsync^(u =^> u.RefreshTokens.Any^(t =^> t.Token == refreshToken^)^);
    echo     ^}
    echo.
    echo     public async Task^<Usuario^> GetByUsernameAsync^(string username^)
    echo     ^{
    echo         return await _context.Usuarios
    echo             .Include^(u =^> u.Rols^)
    echo             .Include^(u =^> u.RefreshTokens^)
    echo             .FirstOrDefaultAsync^(u =^> u.Nombre.ToLower^(^) == username.ToLower^(^)^);
    echo     ^}
    echo     public override async Task^<IEnumerable^<Usuario^>^> GetAllAsync^(^)
    echo     ^{
    echo         return await _context.Usuarios
    echo             .ToListAsync^(^);
    echo     ^}
    echo.
    echo     public override async Task^<Usuario^> GetByIdAsync^(int id^)
    echo     ^{
    echo         return await _context.Usuarios
    echo         .FirstOrDefaultAsync^(p =^>  p.Id == id^);
    echo     ^}
    echo     public override async Task^<^(int totalRegistros, IEnumerable^<Usuario^> registros^)^> GetAllAsync^(int pageIndez, int pageSize, string search^)
    echo     ^{
    echo         var query = _context.Usuarios as IQueryable^<Usuario^>;
    echo.
    echo         if^(!string.IsNullOrEmpty^(search^)^)
    echo         ^{
    echo             query = query.Where^(p =^> p.Nombre.ToLower^(^).Contains^(search^)^);
    echo         ^}
    echo.
    echo         query = query.OrderBy^(p =^> p.Id^);
    echo.
    echo         var totalRegistros = await query.CountAsync^(^);
    echo         var registros = await query 
    echo             .Skip^(^(pageIndez - 1^) * pageSize^)
    echo             .Take^(pageSize^)
    echo             .ToListAsync^(^);
    echo.
    echo         return ^(totalRegistros, registros^);
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%app%\Repository\UsuarioRepository.cs"

mkdir %DIR_EJECUCION%\%app%\UnitOfWork
(
    echo using Aplicacion.Repository;
    echo using Dominio.Interfaces;
    echo using Persistencia;
    echo.
    echo namespace Aplicacion.UnitOfWork;
    echo public class UnitOfWork  : IUnitOfWork, IDisposable
    echo ^{
    echo    public UnitOfWork^(ApiContext context^)
    echo    ^{
    echo        _context = context;
    echo    ^}
    echo    private readonly ApiContext _context;
    echo    private RolRepository _Rol;
    echo    public IRol Roles
    echo    ^{
    echo        get^{
    echo            if^(_Rol== null^)
    echo            ^{
    echo                _Rol= new RolRepository^(_context^);
    echo            ^}
    echo            return _Rol;
    echo        ^}
    echo    ^}
    echo    private UsuarioRepository _usuarios;
    echo    public IUsuario Usuarios
    echo    ^{
    echo        get^{
    echo            if^(_usuarios== null^)
    echo            ^{
    echo                _usuarios= new UsuarioRepository^(_context^);
    echo            ^}
    echo            return _usuarios;
    echo        ^}
    echo    ^}
) > "%DIR_EJECUCION%\%app%\UnitOfWork\UnitOfWork.cs"

mkdir %DIR_EJECUCION%\%dom%\Entities
(
    echo namespace Dominio.Entities;
    echo public class BaseEntity {
    echo     public int Id { get; set; }
    echo }
) > "%DIR_EJECUCION%\%dom%\Entities\BaseEntity.cs"

(
    echo namespace Dominio.Entities;
    echo public class RefreshToken : BaseEntity
    echo ^{
    echo     public int IdUsuarioFk ^{ get; set; ^}
    echo     public Usuario Usuario ^{ get; set; ^}
    echo     public string Token ^{ get; set; ^}
    echo     public DateTime Expires ^{ get; set; ^}
    echo     public bool IsExpired =^> DateTime.UtcNow ^>= Expires;
    echo     public DateTime Created ^{ get; set; ^}
    echo     public DateTime? Revoked ^{ get; set; ^}
    echo     public bool IsActive =^> Revoked == null ^&^& !IsExpired;
    echo ^}

) > "%DIR_EJECUCION%\%dom%\Entities\RefreshToken.cs"

(
    echo namespace Dominio.Entities;
    echo public class Rol : BaseEntity
    echo ^{
    echo     public string Nombre ^{ get; set; ^}
    echo.
    echo     public ICollection^<Usuario^> Usuarios ^{ get; set; ^} = new HashSet^<Usuario^>^(^);
    echo     public ICollection^<RolUsuario^> RolUsuarios ^{ get; set; ^}
    echo ^}
) > "%DIR_EJECUCION%\%dom%\Entities\Rol.cs"

(
    echo namespace Dominio.Entities;
    echo public class RolUsuario
    echo ^{
    echo     public int IdRolFk ^{ get; set; ^}
    echo     public Rol Rol ^{ get; set; ^}
    echo     public int IdUsuarioFk ^{ get; set; ^}
    echo     public Usuario Usuario ^{ get; set; ^}
    echo ^}
) > "%DIR_EJECUCION%\%dom%\Entities\RolUsuario.cs"

(
    echo namespace Dominio.Entities;
    echo public class Usuario: BaseEntity
    echo ^{
    echo     public string Nombre ^{ get; set; ^}
    echo     public string Email ^{ get; set; ^}
    echo     public string Password ^{ get; set; ^}  
    echo.
    echo     public ICollection^<Rol^> Rols ^{ get; set; ^} = new HashSet^<Rol^>^(^);
    echo     public ICollection^<RefreshToken^> RefreshTokens ^{ get; set; ^} = new HashSet^<RefreshToken^>^(^);
    echo     public ICollection^<RolUsuario^> RolUsuarios ^{ get; set; ^}
    echo ^}
) > "%DIR_EJECUCION%\%dom%\Entities\Usuario.cs"

mkdir %DIR_EJECUCION%\%dom%\Interfaces
(
    echo using System.Linq.Expressions;
    echo using Dominio.Entities;
    echo namespace Dominio.Interfaces;
    echo public interface IGenericRepo ^<T^> where T : BaseEntity
    echo ^{
    echo     Task^<T^> GetByIdAsync^(int id^);
    echo     Task^<IEnumerable^<T^>^> GetAllAsync^(^);
    echo     Task^<^(int totalRegistros, IEnumerable^<T^> registros^)^> GetAllAsync^(int pageIndex, int pageSize, string search^);
    echo     Task^<^(int totalRegistros, IEnumerable^<T^> registros^)^> GetAllAsync^(int pageIndex, int pageSize, int search^);
    echo     IEnumerable^<T^> Find^(Expression^<Func^<T, bool^>^> expression^);
    echo     void Add^(T entity^);
    echo     void AddRange^(IEnumerable^<T^> entities^);
    echo     void Remove^(T entity^);
    echo     void RemoveRange^(IEnumerable^<T^> entities^);
    echo     void Update^(T entity^);
    echo ^}
) > "%DIR_EJECUCION%\%dom%\Interfaces\IGenericRepo.cs"

(
    echo namespace Dominio.Interfaces;
    echo public interface IUnitOfWork
    echo ^{
    echo    IRol Roles ^{ get; ^}
    echo    IUsuario Usuarios ^{ get; ^}
) > "%DIR_EJECUCION%\%dom%\Interfaces\IUnitOfWork.cs"

(
    echo using Dominio.Entities;
    echo namespace Dominio.Interfaces;
    echo public interface IRol : IGenericRepo^<Rol^>
    echo ^{
    echo ^}
) > "%DIR_EJECUCION%\%dom%\Interfaces\IRol.cs"

(
    echo using Dominio.Entities;
    echo namespace Dominio.Interfaces;
    echo public interface IUsuario : IGenericRepo^<Usuario^>
    echo ^{
    echo    Task^<Usuario^> GetByUsernameAsync^(string username^);
    echo    Task^<Usuario^> GetByRefreshTokenAsync^(string username^);
    echo ^}
) > "%DIR_EJECUCION%\%dom%\Interfaces\IUsuario.cs"

mkdir %DIR_EJECUCION%\%persistencia%\Data
mkdir %DIR_EJECUCION%\%persistencia%\Data\Configuration
(
    echo using Dominio.Entities;
    echo using Microsoft.EntityFrameworkCore;
    echo using Microsoft.EntityFrameworkCore.Metadata.Builders;
    echo.
    echo namespace Persistencia.Data.Configuration;
    echo public class RolConfiguration: IEntityTypeConfiguration^<Rol^>
    echo ^{
    echo     public void Configure^(EntityTypeBuilder^<Rol^> builder^)
    echo     ^{
    echo.
    echo         builder.ToTable^("rol"^);
    echo         builder.HasKey^(p =^> p.Id^);
    echo.     
    echo         builder.Property(p =^> p.Id^)
    echo         .IsRequired^(^);
    echo.    
    echo         builder.Property^(p =^> p.Nombre^)
    echo         .HasColumnName^("rolName"^)
    echo         .HasColumnType^("varchar"^)
    echo         .HasMaxLength^(255^)
    echo         .IsRequired^(^);
    echo.   
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%persistencia%\Data\Configuration\RolConfiguration.cs"
(
    echo using Dominio.Entities;
    echo using Microsoft.EntityFrameworkCore;
    echo using Microsoft.EntityFrameworkCore.Metadata.Builders;
    echo.
    echo namespace Persistencia.Data.Configuration;
    echo public class UserConfiguration : IEntityTypeConfiguration^<Usuario^>
    echo ^{
    echo     public void Configure^(EntityTypeBuilder^<Usuario^> builder^)
    echo     ^{
    echo         ^{
    echo             builder.ToTable^("usuario"^);
    echo.
    echo             builder.Property^(p =^> p.Id^)
    echo             .IsRequired^(^);
    echo.
    echo             builder.Property^(p =^> p.Nombre^)
    echo             .HasColumnName^("nombre"^)
    echo             .HasMaxLength^(50^)
    echo             .IsRequired^(^);
    echo.
    echo             builder.Property^(p =^> p.Email^)
    echo         .HasColumnName^("email"^)
    echo         .IsRequired^(^);
    echo.
    echo             builder.Property^(p =^> p.Password^)
    echo         .HasMaxLength^(255^)
    echo         .IsRequired^(^);
    echo.
    echo             builder
    echo         .HasMany^(p =^> p.Rols^)
    echo         .WithMany^(r =^> r.Usuarios^)
    echo         .UsingEntity^<RolUsuario^>^(
    echo.
    echo             j =^> j
    echo             .HasOne^(pt =^> pt.Rol^)
    echo             .WithMany^(t =^> t.RolUsuarios^)
    echo             .HasForeignKey^(ut =^> ut.IdRolFk^),
    echo.
    echo.
    echo             j =^> j
    echo             .HasOne^(et =^> et.Usuario^)
    echo             .WithMany^(et =^> et.RolUsuarios^)
    echo             .HasForeignKey^(el =^> el.IdUsuarioFk^),
    echo.
    echo             j =^>
    echo             ^{
    echo                 j.ToTable^("userRol"^);
    echo                 j.HasKey^(t =^> new { t.IdUsuarioFk, t.IdRolFk }^);
    echo.
    echo             ^}^);
    echo.
    echo             builder.HasMany^(p =^> p.RefreshTokens^)
    echo             .WithOne^(p =^> p.Usuario^)
    echo             .HasForeignKey^(p =^> p.IdUsuarioFk^);
    echo.
    echo.    
    echo         ^}
    echo.
    echo     ^}
    echo ^}

) > "%DIR_EJECUCION%\%persistencia%\Data\Configuration\UserConfiguration.cs"
(
    echo using Microsoft.AspNetCore.Mvc;
    echo.
    echo namespace API.Controllers;
    echo ^[ApiController^]
    echo ^[Route^("api/[controller]"^)^]
    echo public class BaseApiController : Controller
    echo ^{
    echo.
    echo ^}
) > "%DIR_EJECUCION%\%folderName%\Controllers\BaseApiController.cs"
(
    echo using API.Dtos;
    echo using API.Helpers.Errors;
    echo using AutoMapper;
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.AspNetCore.Authorization;
    echo using Microsoft.AspNetCore.Mvc;
    echo.
    echo namespace API.Controllers;
    echo ^[ApiVersion^("1.0"^)^]
    echo ^[ApiVersion^("1.1"^)^]
    echo ^[Authorize^]
    echo public class RolController : BaseApiController
    echo ^{
    echo     private readonly IUnitOfWork unitofwork;
    echo     private readonly  IMapper mapper;
    echo.
    echo     public RolController^( IUnitOfWork unitofwork, IMapper mapper^)
    echo     ^{
    echo         this.unitofwork = unitofwork;
    echo         this.mapper = mapper;
    echo     ^}
    echo     ^[HttpGet^]
    echo     ^[MapToApiVersion^("1.0"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     public async Task^<ActionResult^<IEnumerable^<RolDto^>^>^> Get^(^)
    echo     ^{
    echo         var entidad = await unitofwork.Roles.GetAllAsync^(^);
    echo         return mapper.Map^<List^<RolDto^>^>^(entidad^);
    echo     ^}
    echo.
    echo     ^[HttpGet^("{id}"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
    echo     public async Task^<ActionResult^<RolDto^>^> Get^(int id^)
    echo     ^{
    echo         var entidad = await unitofwork.Roles.GetByIdAsync^(id^);
    echo         if ^(entidad == null^)^{
    echo             return NotFound^(^);
    echo         ^}
    echo         return this.mapper.Map^<RolDto^>^(entidad^);
    echo     ^}
    echo     ^[HttpGet^]
    echo     ^[MapToApiVersion^("1.1"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     public async Task^<ActionResult^<Pager^<RolDto^>^>^> GetPagination^(^[FromQuery^] Params paisParams^)
    echo     ^{
    echo         var entidad = await unitofwork.Roles.GetAllAsync^(paisParams.PageIndex, paisParams.PageSize, paisParams.Search^);
    echo         var listEntidad = mapper.Map^<List^<RolDto^>^>^(entidad.registros^);
    echo         return new Pager^<RolDto^>^(listEntidad, entidad.totalRegistros, paisParams.PageIndex, paisParams.PageSize, paisParams.Search^);
    echo     ^}
    echo.
    echo     ^[HttpPost^]
    echo     ^[ProducesResponseType^(StatusCodes.Status201Created^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     public async Task^<ActionResult^<Rol^>^> Post^(RolDto entidadDto^)
    echo     ^{
    echo         var entidad = this.mapper.Map^<Rol^>^(entidadDto^);
    echo         this.unitofwork.Roles.Add^(entidad^);
    echo         await unitofwork.SaveAsync^(^);
    echo         if^(entidad == null^)
    echo         ^{
    echo             return BadRequest^(^);
    echo         ^}
    echo         entidadDto.Id = entidad.Id;
    echo         return CreatedAtAction^(nameof^(Post^), new ^{id = entidadDto.Id^}, entidadDto^);
    echo     ^}
    echo     ^[HttpPut^("{id}"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
    echo.
    echo     public async Task^<ActionResult^<RolDto^>^> Put^(int id, ^[FromBody^]RolDto entidadDto^)^{
    echo         if^(entidadDto == null^)
    echo         ^{
    echo             return NotFound^(^);
    echo         ^}
    echo         var entidad = this.mapper.Map^<Rol^>^(entidadDto^);
    echo         unitofwork.Roles.Update^(entidad^);
    echo         await unitofwork.SaveAsync^(^);
    echo         return entidadDto;
    echo     ^}
    echo     ^[HttpDelete^("{id}"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status204NoContent^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
    echo     public async Task^<IActionResult^> Delete^(int id^)^{
    echo         var entidad = await unitofwork.Roles.GetByIdAsync^(id^);
    echo         if^(entidad == null^)
    echo         ^{
    echo             return NotFound^(^);
    echo         ^}
    echo         unitofwork.Roles.Remove^(entidad^);
    echo         await unitofwork.SaveAsync^(^);
    echo         return NoContent^(^);
    echo     ^}
    echo ^}
) > "%DIR_EJECUCION%\%folderName%\Controllers\RolController.cs"
(
    echo using API.Dtos;
    echo using API.Helpers.Errors;
    echo using API.Services;
    echo using AutoMapper;
    echo using Dominio.Entities;
    echo using Dominio.Interfaces;
    echo using Microsoft.AspNetCore.Authorization;
    echo using Microsoft.AspNetCore.Mvc;
    echo.
    echo namespace API.Controllers;
    echo ^[ApiVersion^("1.0"^)^]
    echo ^[ApiVersion^("1.1"^)^]
    echo public class UsuarioController : BaseApiController
    echo ^{
    echo     private readonly IUserService _Usuarioservice;
    echo     private readonly IUnitOfWork unitofwork;
    echo     private readonly IMapper mapper;
    echo.
    echo     public UsuarioController^(IUserService Usuarioservice, IUnitOfWork unitofwork, IMapper mapper^)
    echo     ^{
    echo         this.unitofwork = unitofwork;
    echo         this.mapper = mapper;
    echo         _Usuarioservice = Usuarioservice;
    echo     ^}
    echo     ^[HttpGet^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     ^[MapToApiVersion^("1.0"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     public async Task^<ActionResult^<IEnumerable^<UsuarioDto^>^>^> Get^(^)
    echo     ^{
    echo         var entidad = await unitofwork.Usuarios.GetAllAsync^(^);
    echo         return mapper.Map^<List^<UsuarioDto^>^>^(entidad^);
    echo     ^}
    echo     ^[HttpGet^("{id}"^)^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
    echo.
    echo     public async Task^<ActionResult^<UsuarioDto^>^> Get^(int id^)
    echo     ^{
    echo         var entidad = await unitofwork.Usuarios.GetByIdAsync^(id^);
    echo         if ^(entidad == null^)
    echo         ^{
    echo             return NotFound^(^);
    echo         ^}
    echo         return this.mapper.Map^<UsuarioDto^>^(entidad^);
    echo     ^}
    echo     ^[HttpGet^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     ^[MapToApiVersion^("1.1"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     public async Task^<ActionResult^<Pager^<UsuarioDto^>^>^> GetPagination^(^[FromQuery^] Params paisParams^)
    echo     ^{
    echo         var entidad = await unitofwork.Usuarios.GetAllAsync^(paisParams.PageIndex, paisParams.PageSize, paisParams.Search^);
    echo         var listEntidad = mapper.Map^<List^<UsuarioDto^>^>^(entidad.registros^);
    echo         return new Pager^<UsuarioDto^>^(listEntidad, entidad.totalRegistros, paisParams.PageIndex, paisParams.PageSize, paisParams.Search^);
    echo     ^}
    echo     ^[HttpPost^("register"^)^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     public async Task^<ActionResult^> RegisterAsync^(RegisterDto model^)
    echo     ^{
    echo         var result = await _Usuarioservice.RegisterAsync^(model^);
    echo         return Ok^(result^);
    echo     ^}
    echo.
    echo     ^[HttpPost^("token"^)^]
    echo     public async Task^<IActionResult^> GetTokenAsync^(LoginDto model^)
    echo     ^{
    echo         var result = await _Usuarioservice.GetTokenAsync^(model^);
    echo         SetRefreshTokenInCookie^(result.RefreshToken^);
    echo         return Ok^(result^);
    echo     ^}
    echo.  
    echo     ^[HttpPost^("addrole"^)^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     public async Task^<IActionResult^> AddRoleAsync^(AddRoleDto model^)
    echo     ^{
    echo         var result = await _Usuarioservice.AddRoleAsync^(model^);
    echo         return Ok^(result^);
    echo     ^}
    echo.
    echo     ^[HttpPost^("refresh-token"^)^]
    echo     ^[Authorize^]
    echo     public async Task^<IActionResult^> RefreshToken^(^)
    echo     ^{
    echo         var refreshToken = Request.Cookies^["refreshToken"^];
    echo         var response = await _Usuarioservice.RefreshTokenAsync^(refreshToken^);
    echo         if ^(!string.IsNullOrEmpty^(response.RefreshToken^)^)
    echo             SetRefreshTokenInCookie^(response.RefreshToken^);
    echo         return Ok^(response^);
    echo     ^}
    echo.
    echo.
    echo     ^[HttpPut^("{id}"^)^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
    echo.
    echo     public async Task^<ActionResult^<UsuarioDto^>^> Put^(int id, ^[FromBody^] UsuarioDto entidadDto^)
    echo     ^{
    echo         if ^(entidadDto == null^)
    echo         ^{
    echo             return NotFound^(^);
    echo         ^}
    echo         var entidad = this.mapper.Map^<Usuario^>^(entidadDto^);
    echo         unitofwork.Usuarios.Update^(entidad^);
    echo         await unitofwork.SaveAsync^(^);
    echo         return entidadDto;
    echo     ^}
    echo.
    echo     ^[HttpDelete^("{id}"^)^]
    echo     ^[Authorize^(Roles = "Administrador"^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status204NoContent^)^]
    echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
    echo     public async Task^<IActionResult^> Delete^(int id^)
    echo     ^{
    echo         var entidad = await unitofwork.Usuarios.GetByIdAsync^(id^);
    echo         if ^(entidad == null^)
    echo         ^{
    echo             return NotFound^(^);
    echo         ^}
    echo         unitofwork.Usuarios.Remove^(entidad^);
    echo         await unitofwork.SaveAsync^(^);
    echo         return NoContent^(^);
    echo     ^}
    echo     private void SetRefreshTokenInCookie^(string refreshToken^)
    echo     ^{
    echo         var cookieOptions = new CookieOptions
    echo         ^{
    echo             HttpOnly = true,
    echo             Expires = DateTime.UtcNow.AddDays^(10^),
    echo         ^};
    echo         Response.Cookies.Append^("refreshToken", refreshToken, cookieOptions^);
    echo     ^}
    echo.
    echo ^}

) > "%DIR_EJECUCION%\%folderName%\Controllers\UsuarioController.cs"
mkdir %DIR_EJECUCION%\%persistencia%\Data\Csv
(
    echo IdUsuarioFk,IdRolFk
    echo 1,1
    echo 2,2
    echo 3,2
) > "%DIR_EJECUCION%\%persistencia%\Data\Csv\RoleUser.csv"
(
    echo Id,Nombre,Email,Password
    echo 1,admin,admin@example.com,AQAAAAIAAYagAAAAEGi0FjrgCdfzlsJOcti7rJQq1k5DB4Cpr6ICusQEnePc6f78PE1IhgVuIzm6rwMeDA==
    echo 2,Usuario2,usuario2@example.com,AQAAAAIAAYagAAAAEGi0FjrgCdfzlsJOcti7rJQq1k5DB4Cpr6ICusQEnePc6f78PE1IhgVuIzm6rwMeDA==
    echo 3,Usuario3,usuario3@example.com,AQAAAAIAAYagAAAAEGi0FjrgCdfzlsJOcti7rJQq1k5DB4Cpr6ICusQEnePc6f78PE1IhgVuIzm6rwMeDA==
) > "%DIR_EJECUCION%\%persistencia%\Data\Csv\User.csv"

REM Preguntar el numero de entidades
SET /P numEntities="Ingrese el numero de entidades: "

REM Crear archivos .cs para cada entidad en la carpeta Dominio\Entities

for /L %%i in (1, 1, %numEntities%) do (
    SET /P entityName="Ingrese el nombre de la entidad %%i: "
    (
        echo namespace Dominio.Entities;
        echo public class !entityName! : BaseEntity
        echo ^{
        echo.
        echo ^}
    ) >> "%DIR_EJECUCION%\%dom%\Entities\!entityName!.cs"

    (
        echo    public DbSet^<!entityName!^> !entityName!s ^{ get; set; ^}
    ) >> "%DIR_EJECUCION%\%persistencia%\ApiContext.cs"

    (
        echo    I!entityName! !entityName!s ^{ get; ^}
    ) >> "%DIR_EJECUCION%\%dom%\Interfaces\IUnitOfWork.cs"

    (
        echo    private !entityName!Repository _!entityName!s;
    ) >> "%DIR_EJECUCION%\%app%\UnitOfWork\UnitOfWork.cs"

    (
        echo        CreateMap^<!entityName!,!entityName!Dto^>^(^).ReverseMap^(^);
    ) >> "%DIR_EJECUCION%\%folderName%\Profiles\MappingProfiles.cs"
    
    (
        echo using Dominio.Entities;
        echo namespace API.Dtos;
        echo public class !entityName!Dto : BaseEntity
        echo ^{
        echo ^}
    ) >> "%DIR_EJECUCION%\%folderName%\Dtos\!entityName!Dto.cs"

    (
        echo using Dominio.Entities;
        echo using Microsoft.EntityFrameworkCore;
        echo using Microsoft.EntityFrameworkCore.Metadata.Builders;
        echo.
        echo namespace Persistencia.Data.Configuration;
        echo public class !entityName!Configuration : IEntityTypeConfiguration^<!entityName!^> 
        echo ^{
        echo     public void Configure^(EntityTypeBuilder^<!entityName!^> builder^)
        echo     ^{
        echo.
        echo         builder.ToTable^("!entityName!"^);
        echo         builder.HasKey^(p =^> p.Id^);
        echo.
        echo         builder.Property^(p =^> p.Id^)
        echo         .IsRequired^(^);
        echo.
        echo         builder.Property^(p =^> p.Nombre^)
        echo         .HasColumnName^("Nombre"^)
        echo         .HasColumnType^("varchar"^)
        echo         .HasMaxLength^(255^)
        echo         .IsRequired^(^);
        echo.
        echo     ^}
        echo ^}

    ) >> "%DIR_EJECUCION%\%persistencia%\Data\Configuration\!entityName!Configuration.cs"

	(
		echo using Dominio.Entities;
		echo namespace Dominio.Interfaces;
		echo public interface I!entityName! : IGenericRepo^<!entityName!^>
		echo ^{
		echo ^}
	) >> "%DIR_EJECUCION%\%dom%\Interfaces\I!entityName!.cs"

    (
        echo    public I!entityName! !entityName!s
        echo    ^{
        echo        get^{
        echo            if^(_!entityName!s== null^)
        echo            ^{
        echo                _!entityName!s= new !entityName!Repository^(_context^);
        echo            ^}
        echo            return _!entityName!s;
        echo        ^}
        echo    ^}
    ) >> "%DIR_EJECUCION%\%app%\UnitOfWork\UnitOfWork.cs"

	(
        echo using Dominio.Entities;
        echo using Dominio.Interfaces;
        echo using Microsoft.EntityFrameworkCore;
        echo using Persistencia;
        echo namespace Aplicacion.Repository;
        echo     public class !entityName!Repository  : GenericRepo^<!entityName!^>, I!entityName!
        echo ^{
        echo     protected readonly ApiContext _context;
        echo     public !entityName!Repository^(ApiContext context^) : base ^(context^)
        echo     ^{
        echo         _context = context;
        echo     ^}
        echo     public override async Task^<IEnumerable^<!entityName!^>^> GetAllAsync^(^)
        echo     ^{
        echo         return await _context.!entityName!s
        echo             .ToListAsync^(^);
        echo     ^}
        echo     public override async Task^<!entityName!^> GetByIdAsync^(int id^)
        echo     ^{
        echo         return await _context.!entityName!s
        echo         .FirstOrDefaultAsync^(p =^>  p.Id ^=^= id^);
        echo     ^}
        echo     public override async Task^<(int totalRegistros, IEnumerable^<!entityName!^> registros^)^> GetAllAsync^(int pageIndez, int pageSize, string search^)
        echo     ^{
        echo         var query = _context.!entityName!s as IQueryable^<!entityName!^>;
        echo         if^(!string.IsNullOrEmpty^(search^)^)
        echo         ^{
        echo             query = query.Where^(p =^> p.Nombre.ToLower^(^)^.Contains^(search^)^);
        echo         ^}
        echo         query = query.OrderBy^(p =^> p.Id^);
        echo         var totalRegistros = await query.CountAsync^(^);
        echo         var registros = await query 
        echo             .Skip^(^(pageIndez - 1^) * pageSize^)
        echo             .Take^(pageSize^)
        echo             .ToListAsync^(^);
        echo         return ^(totalRegistros, registros^);
        echo     ^}
        echo ^}
        
    ) >> "%DIR_EJECUCION%\%app%\Repository\!entityName!Repository.cs"

    (
		
        echo using API.Dtos;
        echo using API.Helpers.Errors;
        echo using AutoMapper;
        echo using Dominio.Entities;
        echo using Dominio.Interfaces;
        echo using Microsoft.AspNetCore.Authorization;
        echo using Microsoft.AspNetCore.Mvc;
        echo.
        echo namespace API.Controllers;
        echo ^[ApiVersion^("1.0"^)^]
        echo ^[ApiVersion^("1.1"^)^]
        echo ^[Authorize^]
        echo.
        echo public class !entityName!Controller : BaseApiController
        echo ^{
        echo     private readonly IUnitOfWork unitofwork;
        echo     private readonly  IMapper mapper;
        echo.
        echo     public !entityName!Controller^(IUnitOfWork unitofwork, IMapper mapper^)
        echo     ^{
        echo         this.unitofwork = unitofwork;
        echo         this.mapper = mapper;
        echo     ^}
        echo.
        echo     ^[HttpGet^]
        echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
        echo.
        echo     public async Task^<ActionResult^<IEnumerable^<!entityName!Dto^>^>^> Get^(^)
        echo     ^{
        echo         var !entityName! = await unitofwork.!entityName!s.GetAllAsync^(^);
        echo         return mapper.Map^<List^<!entityName!Dto^>^>^(!entityName!^);
        echo     ^}
        echo    ^[HttpGet^]
        echo    ^[MapToApiVersion^("1.1"^)^]
        echo    ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
        echo    ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
        echo    public async Task^<ActionResult^<Pager^<!entityName!Dto^>^>^> GetPagination^(^[FromQuery^] Params EntidadParams^)
        echo    ^{
        echo        var entidad = await unitofwork.!entityName!es.GetAllAsync^(EntidadParams.PageIndex, EntidadParams.PageSize, EntidadParams.Search^);
        echo        var listEntidad = mapper.Map^<List^<!entityName!Dto^>^>^(entidad.registros^);
        echo        return new Pager^<RolDto^>^(listEntidad, entidad.totalRegistros, EntidadParams.PageIndex, EntidadParams.PageSize, EntidadParams.Search^);
        echo    ^}
        echo.
        echo     ^[HttpGet^("{id}"^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
        echo.
        echo     public async Task^<ActionResult^<!entityName!Dto^>^> Get^(int id^)
        echo     ^{
        echo         var !entityName! = await unitofwork.!entityName!s.GetByIdAsync^(id^);
        echo         if ^(!entityName! == null^)^{
        echo             return NotFound^(^);
        echo         ^}
        echo         return this.mapper.Map^<!entityName!Dto^>^(!entityName!^);
        echo     ^}
        echo.
        echo     ^[HttpPost^]
        echo     ^[ProducesResponseType^(StatusCodes.Status201Created^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
        echo.
        echo     public async Task^<ActionResult^<!entityName!^>^> Post^(!entityName!Dto !entityName!Dto^)
        echo     ^{
        echo         var !entityName! = this.mapper.Map^<!entityName!^>^(!entityName!Dto^);
        echo         this.unitofwork.!entityName!s.Add^(!entityName!^);
        echo         await unitofwork.SaveAsync^(^);
        echo         if^(!entityName! == null^)
        echo         ^{
        echo             return BadRequest^(^);
        echo         ^}
        echo         !entityName!Dto.Id = !entityName!.Id;
        echo         return CreatedAtAction^(nameof^(Post^), new ^{id = !entityName!Dto.Id^}, !entityName!Dto^);
        echo     ^}
        echo.
        echo     ^[HttpPut^("{id}"^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status200OK^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status400BadRequest^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
        echo.
        echo     public async Task^<ActionResult^<!entityName!Dto^>^> Put^(int id, ^[FromBody^]!entityName!Dto !entityName!Dto^)^{
        echo         if^(!entityName!Dto == null^)
        echo         ^{
        echo             return NotFound^(^);
        echo         ^}
        echo         var !entityName! = this.mapper.Map^<!entityName!^>^(!entityName!Dto^);
        echo         unitofwork.!entityName!s.Update^(!entityName!^);
        echo         await unitofwork.SaveAsync^(^);
        echo         return !entityName!Dto;
        echo     ^}
        echo.
        echo     ^[HttpDelete^("{id}"^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status204NoContent^)^]
        echo     ^[ProducesResponseType^(StatusCodes.Status404NotFound^)^]
        echo.
        echo     public async Task^<IActionResult^> Delete^(int id^)^{
        echo         var !entityName! = await unitofwork.!entityName!s.GetByIdAsync^(id^);
        echo         if^(!entityName! == null^)
        echo         {
        echo             return NotFound^(^);
        echo         ^}
        echo         unitofwork.!entityName!s.Remove^(!entityName!^);
        echo         await unitofwork.SaveAsync^(^);
        echo         return NoContent^(^);
        echo     ^}
        echo ^}

	) >> "%DIR_EJECUCION%\%folderName%\Controllers\!entityName!Controller.cs"
)
(
    echo protected override void OnModelCreating^(ModelBuilder modelBuilder^)
    echo ^{
    echo    base.OnModelCreating^(modelBuilder^);
    echo.
    echo    modelBuilder.ApplyConfigurationsFromAssembly^(Assembly.GetExecutingAssembly^(^)^);
    echo ^}
    echo.
    echo ^}
) >> "%DIR_EJECUCION%\%persistencia%\ApiContext.cs"
(
    echo Task^<int^> SaveAsync^(^);
    echo ^}
) >> "%DIR_EJECUCION%\%dom%\Interfaces\IUnitOfWork.cs"
(
    echo    public void Dispose^(^)
    echo    ^{
    echo        _context.Dispose^(^);
    echo    ^}
    echo    public async Task^<int^> SaveAsync^(^)
    echo    ^{
    echo        return await _context.SaveChangesAsync^(^);
    echo    ^} 
    echo    ^} 
) >>"%DIR_EJECUCION%\%app%\UnitOfWork\UnitOfWork.cs"
(
    echo    ^}
    echo ^}
) >> "%DIR_EJECUCION%\%folderName%\Profiles\MappingProfiles.cs"
(
    echo ^<Project Sdk="Microsoft.NET.Sdk"^>
    echo.
    echo ^<ItemGroup^>
    echo     ^<None Include="Data\Csv\**" CopyToOutputDirectory="PreserveNewest" /^> 
    echo     ^<ProjectReference Include="..\Dominio\Dominio.csproj" /^>
    echo ^</ItemGroup^>
    echo.
    echo ^<ItemGroup^>
    echo     ^<PackageReference Include="CsvHelper" Version="30.0.1" /^>
    echo     ^<PackageReference Include="Microsoft.EntityFrameworkCore" Version="7.0.12" /^>
    echo     ^<PackageReference Include="Pomelo.EntityFrameworkCore.MySql" Version="7.0.0" /^>
    echo ^</ItemGroup^>
    echo.
    echo ^<PropertyGroup^>
    echo     ^<TargetFramework^>net7.0^</TargetFramework^>
    echo     ^<ImplicitUsings^>enable^</ImplicitUsings^>
    echo     ^<Nullable^>enable^</Nullable^>
    echo ^</PropertyGroup^>
    echo.
    echo ^</Project^>


) > "%DIR_EJECUCION%\%persistencia%\Persistencia.csproj"
echo Gracias por usar nuestro Creador de proyectos!
echo Echo por Omapache 
pause
exit
ENDLOCAL
