using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Dtos
{
    public class CalificacionDto
    {
        public int Id { get; set; }

        public string Nota { get; set; } = null!;

        public string Comentarios { get; set; }

        public int IdEstudiante { get; set; }

        public int IdCurso { get; set; }
    }
}