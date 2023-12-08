
namespace FrontEval.Data
{
    public class Curso
    {
        public int id { get; set; }
        public string nombre { get; set; }
        public string descripcion { get; set; }
        public DateTime fechaInicio { get; set; }
        public DateTime fechaFinalizacion { get; set; }
        public string evaluacion { get; set; }
        public int idEstudiante { get; set; }
        public int idProfesor { get; set; }

    }
}
