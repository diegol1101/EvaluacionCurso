using Domain.Entities;

namespace Domain.Interfaces
{
    public interface IProfesor :IGenericRepository<Profesor>
    {
        Task<IEnumerable<object>> ProfesorDpto();
    }
}