using Application.Repository;
using Domain.Entities;
using Domain.Interfaces;
using Persistence;
using Persistence.Data;

namespace Application.UnitOfWork;

public class UnitOfWork : IUnitOfWork, IDisposable
{
    private readonly DbAppContext _context;

    private CalificacionRepository _calificaciones;
    private CursoRepository _cursos;
    private DepartamentoRepository _departamentos;
    private EstudianteRepository _estudiantes;
    private ProfesorRepository _profesores;
    private RolRepository _roles;
    private UserRepository _users;



    public UnitOfWork(DbAppContext context)
    {
        _context = context;
    }


    public ICalificacion Calificaciones
    {
        get
        {
            if (_calificaciones == null)
            {
                _calificaciones = new CalificacionRepository(_context);
            }
            return _calificaciones;
        }
    }

    public ICurso Cursos
    {
        get
        {
            if (_cursos == null)
            {
                _cursos = new CursoRepository(_context);
            }
            return _cursos;
        }
    }

    public IDepartamento Departamentos
    {
        get
        {
            if (_departamentos == null)
            {
                _departamentos = new DepartamentoRepository(_context);
            }
            return _departamentos;
        }
    }

    public IEstudiante Estudiantes
    {
        get
        {
            if (_estudiantes == null)
            {
                _estudiantes = new EstudianteRepository(_context);
            }
            return _estudiantes;
        }
    }

    public IProfesor Profesores
    {
        get
        {
            if (_profesores == null)
            {
                _profesores = new ProfesorRepository(_context);
            }
            return _profesores;
        }
    }

        public IRol Roles
    {
        get
        {
            if (_roles == null)
            {
                _roles = new RolRepository(_context);
            }
            return _roles;
        }
    }

        public IUser Users
    {
        get
        {
            if (_users == null)
            {
                _users = new UserRepository(_context);
            }
            return _users;
        }
    }



    public void Dispose()
    {
        _context.Dispose();
    }
    public async Task<int> SaveAsync()
    {
        return await _context.SaveChangesAsync();
    }
}