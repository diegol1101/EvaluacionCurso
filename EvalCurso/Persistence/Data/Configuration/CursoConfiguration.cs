using Microsoft.EntityFrameworkCore;
using Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace Persistence.Data.Configuration;

public class CursoConfiguration : IEntityTypeConfiguration<Curso>
{
    public void Configure(EntityTypeBuilder<Curso> builder)
    {
        builder.HasKey(e => e.Id).HasName("PK__curso__3214EC07FD86C9C6");

            builder.ToTable("curso");

            builder.Property(e => e.Descripcion)
                .HasMaxLength(300)
                .IsUnicode(false);
            builder.Property(e => e.Evaluacion)
                .HasMaxLength(120)
                .IsUnicode(false);
            builder.Property(e => e.FechaFinalizacion)
                .HasColumnType("date")
                .HasColumnName("Fecha_Finalizacion");
            builder.Property(e => e.FechaInicio)
                .HasColumnType("date")
                .HasColumnName("Fecha_Inicio");
            builder.Property(e => e.IdEstudiante).HasColumnName("Id_Estudiante");
            builder.Property(e => e.IdProfesor).HasColumnName("Id_Profesor");
            builder.Property(e => e.Nombre)
                .HasMaxLength(150)
                .IsUnicode(false);

            builder.HasOne(d => d.IdEstudianteNavigation).WithMany(p => p.Cursos)
                .HasForeignKey(d => d.IdEstudiante)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__curso__Id_Estudi__52593CB8");

            builder.HasOne(d => d.IdProfesorNavigation).WithMany(p => p.Cursos)
                .HasForeignKey(d => d.IdProfesor)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__curso__Id_Profes__534D60F1");
    }
}