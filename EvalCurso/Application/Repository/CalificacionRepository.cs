
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Data;

namespace Application.Repository;

    public class CalificacionRepository : GenericRepository<Calificacion>, ICalificacion
    {
        protected readonly DbAppContext _context;

        public CalificacionRepository(DbAppContext context) : base(context)
        {
            _context = context;
        }

        public override async Task<IEnumerable<Calificacion>> GetAllAsync()
        {
            return await _context.Calificacions
                .ToListAsync();
        }

        public override async Task<Calificacion> GetByIdAsync(int id)
        {
            return await _context.Calificacions
            .FirstOrDefaultAsync(p => p.Id== id);
        }

        public async Task<IEnumerable<object>> CalificacionEstudiante()
        {
            var calificacionestudiante = await _context.Calificacions
                                        .Include(c=>c.IdCursoNavigation)
                                        .Include(c=>c.IdEstudianteNavigation)
                                        .Select(c=> new
                                        {
                                            nombre_estudiante = c.IdEstudianteNavigation.Nombre,
                                            apellio_estudiante = c.IdEstudianteNavigation.Apellido,
                                            nombre_curso = c.IdCursoNavigation.Nombre,
                                            calificacion = c.Nota,
                                            comentarios = c.Comentarios
                                        })
                                        .ToListAsync();
            return calificacionestudiante;
        }
    }