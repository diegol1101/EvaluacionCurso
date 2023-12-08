
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Data;

namespace Application.Repository;

    public class DepartamentoRepository : GenericRepository<Departamento>, IDepartamento
    {
        protected readonly DbAppContext _context;

        public DepartamentoRepository(DbAppContext context) : base(context)
        {
            _context = context;
        }

        public override async Task<IEnumerable<Departamento>> GetAllAsync()
        {
            return await _context.Departamentos
                .ToListAsync();
        }

        public override async Task<Departamento> GetByIdAsync(int id)
        {
            return await _context.Departamentos
            .FirstOrDefaultAsync(p => p.Id == id);
        }
    }