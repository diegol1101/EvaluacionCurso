
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Data;

namespace Application.Repository;

public class ProfesorRepository : GenericRepository<Profesor>, IProfesor
{
    protected readonly DbAppContext _context;

    public ProfesorRepository(DbAppContext context) : base(context)
    {
        _context = context;
    }

    public override async Task<IEnumerable<Profesor>> GetAllAsync()
    {
        return await _context.Profesors
            .ToListAsync();
    }

    public override async Task<Profesor> GetByIdAsync(int id)
    {
        return await _context.Profesors
        .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task<IEnumerable<object>> ProfesorDpto()
    {
        var estu = await _context.Profesors
                    .Include(c => c.IdDepartamentoNavigation)
                    .Select(c => new
                    {
                        id = c.Id,
                        id_profesor = c.IdProfesor,
                        nombre = c.Nombre,
                        procedencia = c.IdDepartamentoNavigation.Nombre
                    })
                    .ToListAsync();
        return estu;
    }
}