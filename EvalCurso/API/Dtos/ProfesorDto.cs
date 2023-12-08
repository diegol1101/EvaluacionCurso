using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Dtos
{
    public class ProfesorDto
    {
        public int Id { get; set; }

        public int? IdProfesor { get; set; }

        public string Nombre { get; set; } = null!;

        public int IdDepartamento { get; set; }
    }
}