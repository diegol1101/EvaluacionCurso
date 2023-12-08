using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Estudiante
{
    public int Id { get; set; }

    public int? IdEstudiante { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido { get; set; } = null!;

    public int Edad { get; set; }

    public string Correo { get; set; }

    public virtual ICollection<Calificacion> Calificacions { get; set; } = new List<Calificacion>();

    public virtual ICollection<Curso> Cursos { get; set; } = new List<Curso>();
}
