using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Domain.Entities;
using System.Reflection;

namespace Persistence;

public partial class DbAppContext : DbContext
{
    public DbAppContext()
    {
    }

    public DbAppContext(DbContextOptions<DbAppContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Calificacion> Calificacions { get; set; }

    public virtual DbSet<Curso> Cursos { get; set; }

    public virtual DbSet<Departamento> Departamentos { get; set; }

    public virtual DbSet<Estudiante> Estudiantes { get; set; }

    public virtual DbSet<Profesor> Profesors { get; set; }
    public virtual DbSet<RefreshToken> RefreshTokens { get; set; }
    public virtual DbSet<Rol> Roles { get; set; }
    public virtual DbSet<User> Users { get; set; }
    public virtual DbSet<UserRol> UserRoles { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
    }



}
