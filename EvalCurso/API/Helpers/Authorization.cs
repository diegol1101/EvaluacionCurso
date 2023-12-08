namespace API.Helpers;

public class Authorization
{
    public enum Roles
    {
        Profesor,
        Administrador,
        Estudiante
    }

    public const Roles rol_default = Roles.Estudiante;
}