using API.Dtos;
using AutoMapper;
using Domain.Entities;

namespace API.Profiles;

    public class MappingProfiles:Profile
    {
        public MappingProfiles()
        {
            CreateMap<Calificacion, CalificacionDto>().ReverseMap();
            CreateMap<Curso, CursoDto>().ReverseMap();
            CreateMap<Departamento, DepartamentoDto>().ReverseMap();
            CreateMap<Estudiante, EstudianteDto>().ReverseMap();
            CreateMap<Profesor, ProfesorDto>().ReverseMap();
            CreateMap<Rol, RolDto>().ReverseMap();
            CreateMap<User, UserDto>().ReverseMap();
        }

        

    }