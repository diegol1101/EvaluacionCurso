using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Dtos
{
    public class EstudianteDto
    {
        public int Id { get; set; }

        public int? IdEstudiante { get; set; }

        public string Nombre { get; set; } = null!;

        public string Apellido { get; set; } = null!;

        public int Edad { get; set; }

        public string Correo { get; set; }
    }
}