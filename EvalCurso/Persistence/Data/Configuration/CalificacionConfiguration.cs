using Microsoft.EntityFrameworkCore;
using Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace Persistence.Data.Configuration;

public class CalificacionConfiguration : IEntityTypeConfiguration<Calificacion>
{
    public void Configure(EntityTypeBuilder<Calificacion> builder)
    {
        builder.HasKey(e => e.Id).HasName("PK__califica__3214EC071BF1BE6D");

            builder.ToTable("calificacion");

            builder.Property(e => e.Comentarios)
                .HasMaxLength(80)
                .IsUnicode(false);
            builder.Property(e => e.IdCurso).HasColumnName("Id_Curso");
            builder.Property(e => e.IdEstudiante).HasColumnName("Id_estudiante");
            builder.Property(e => e.Nota)
                .HasMaxLength(80)
                .IsUnicode(false);

            builder.HasOne(d => d.IdCursoNavigation).WithMany(p => p.Calificacions)
                .HasForeignKey(d => d.IdCurso)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__calificac__Id_Cu__571DF1D5");

            builder.HasOne(d => d.IdEstudianteNavigation).WithMany(p => p.Calificacions)
                .HasForeignKey(d => d.IdEstudiante)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__calificac__Id_es__5629CD9C");


    }
}