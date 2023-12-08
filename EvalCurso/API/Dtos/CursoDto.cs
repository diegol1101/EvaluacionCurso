using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Dtos
{
    public class CursoDto
    {
        public int Id { get; set; }

        public string Nombre { get; set; } = null!;

        public string Descripcion { get; set; } = null!;

        public DateTime FechaInicio { get; set; }

        public DateTime FechaFinalizacion { get; set; }

        public string Evaluacion { get; set; } = null!;

        public int IdEstudiante { get; set; }

        public int IdProfesor { get; set; }
    }
}