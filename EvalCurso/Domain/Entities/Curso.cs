using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Curso
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string Descripcion { get; set; } = null!;

    public DateTime FechaInicio { get; set; }

    public DateTime FechaFinalizacion { get; set; }

    public string Evaluacion { get; set; } = null!;

    public int IdEstudiante { get; set; }

    public int IdProfesor { get; set; }

    public virtual ICollection<Calificacion> Calificacions { get; set; } = new List<Calificacion>();

    public virtual Estudiante IdEstudianteNavigation { get; set; } = null!;

    public virtual Profesor IdProfesorNavigation { get; set; } = null!;
}
