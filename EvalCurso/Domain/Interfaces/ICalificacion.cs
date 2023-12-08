using Domain.Entities;

namespace Domain.Interfaces
{
    public interface ICalificacion :IGenericRepository<Calificacion>
    {
        Task<IEnumerable<object>> CalificacionEstudiante();
    }
}