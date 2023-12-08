using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Domain.Interfaces;

    public interface IUnitOfWork
    {   
        
        ICalificacion Calificaciones {get;}
        ICurso Cursos {get;}
        IDepartamento Departamentos {get;}
        IEstudiante Estudiantes {get;}
        IProfesor Profesores {get;}
        IRol Roles {get;}
        IUser Users{get;}
        Task<int> SaveAsync();
    }