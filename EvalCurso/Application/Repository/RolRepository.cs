using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Persistence;

namespace Application.Repository;

    public class RolRepository: GenericRepository<Rol>, IRol
{
    private readonly DbAppContext _context;

    public RolRepository(DbAppContext context) : base(context)
    {
        _context = context;
    }

    public override async Task<IEnumerable<Rol>> GetAllAsync()
    {
        return await _context.Roles
            .ToListAsync();
    }

    public override async Task<Rol> GetByIdAsync(int id)
    {
        return await _context.Roles
        .FirstOrDefaultAsync(p =>  p.Id == id);
    }
}