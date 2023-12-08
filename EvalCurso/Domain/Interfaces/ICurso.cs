using Domain.Entities;

namespace Domain.Interfaces
{
    public interface ICurso :IGenericRepository<Curso>
    {
        Task<IEnumerable<Curso>> TodosLosCursos();
        Task<IEnumerable<object>> ProfesorCursos();
        Task<IEnumerable<object>> EstudianteCurso();
        
    }
}