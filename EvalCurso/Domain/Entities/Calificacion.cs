using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Calificacion
{
    public int Id { get; set; }

    public string Nota { get; set; } = null!;

    public string Comentarios { get; set; }

    public int IdEstudiante { get; set; }

    public int IdCurso { get; set; }

    public virtual Curso IdCursoNavigation { get; set; } = null!;

    public virtual Estudiante IdEstudianteNavigation { get; set; } = null!;
}
