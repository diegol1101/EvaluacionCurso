using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Departamento
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<Profesor> Profesors { get; set; } = new List<Profesor>();
}
