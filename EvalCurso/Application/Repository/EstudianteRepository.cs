
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Data;

namespace Application.Repository;

    public class EstudianteRepository : GenericRepository<Estudiante>, IEstudiante
    {
        protected readonly DbAppContext _context;

        public EstudianteRepository(DbAppContext context) : base(context)
        {
            _context = context;
        }

        public override async Task<IEnumerable<Estudiante>> GetAllAsync()
        {
            return await _context.Estudiantes
                .ToListAsync();
        }

        public override async Task<Estudiante> GetByIdAsync(int id)
        {
            return await _context.Estudiantes
            .FirstOrDefaultAsync(p => p.Id == id);
        }

    }