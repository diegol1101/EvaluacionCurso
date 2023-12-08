using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Profesor
{
    public int Id { get; set; }

    public int? IdProfesor { get; set; }

    public string Nombre { get; set; } = null!;

    public int IdDepartamento { get; set; }

    public virtual ICollection<Curso> Cursos { get; set; } = new List<Curso>();

    public virtual Departamento IdDepartamentoNavigation { get; set; } = null!;
}
