
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Data;

namespace Application.Repository;

public class CursoRepository : GenericRepository<Curso>, ICurso
{
    protected readonly DbAppContext _context;

    public CursoRepository(DbAppContext context) : base(context)
    {
        _context = context;
    }

    public override async Task<IEnumerable<Curso>> GetAllAsync()
    {
        return await _context.Cursos
            .ToListAsync();
    }

    public override async Task<Curso> GetByIdAsync(int id)
    {
        return await _context.Cursos
        .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task<IEnumerable<Curso>> TodosLosCursos()
    {
        var todosloscursos = await _context.Cursos
                            .ToListAsync();
        return todosloscursos;
    }

    public async Task<IEnumerable<object>> ProfesorCursos()
    {
        var profecurso = await _context.Cursos
                    .Include(c => c.IdProfesorNavigation)
                    .Select(c => new
                    {
                        curso = c.Nombre,
                        descripcion = c.Descripcion,
                        profesor_nombre = c.IdProfesorNavigation.Nombre
                    })
                    .ToListAsync();
        return profecurso;
    }

    public async Task<IEnumerable<object>> EstudianteCurso()
    {
        var estu = await _context.Cursos
                    .Include(c => c.IdEstudianteNavigation)
                    .Select(c => new
                    {
                        id_estudiante = c.IdEstudianteNavigation.IdEstudiante,
                        nombre_estudiante = c.IdEstudianteNavigation.Nombre,
                        apellido_estudiante = c.IdEstudianteNavigation.Apellido,
                        cursos = c.Nombre
                    })
                    .Distinct()
                    .ToListAsync();
        return estu;
    }


}