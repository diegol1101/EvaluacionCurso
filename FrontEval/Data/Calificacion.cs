using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FrontEval.Data
{
    public class Calificacion
    {
        public int id {get; set;}
        public string nota {get; set;}
        public string comentarios {get; set;}
        public int idEstudiante {get; set;}
        public int idCurso {get; set;}
        
    }
}