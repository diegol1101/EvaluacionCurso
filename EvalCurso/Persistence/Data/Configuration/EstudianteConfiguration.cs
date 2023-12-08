using Microsoft.EntityFrameworkCore;
using Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace Persistence.Data.Configuration;

public class EstudianteConfiguration : IEntityTypeConfiguration<Estudiante>
{
    public void Configure(EntityTypeBuilder<Estudiante> builder)
    {
        builder.HasKey(e => e.Id).HasName("PK__estudian__3214EC07B80E19D0");

        builder.ToTable("estudiante");

        builder.Property(e => e.Apellido)
            .HasMaxLength(80)
            .IsUnicode(false);
        builder.Property(e => e.Correo)
            .HasMaxLength(200)
            .IsUnicode(false);
        builder.Property(e => e.IdEstudiante).HasColumnName("Id_Estudiante");
        builder.Property(e => e.Nombre)
            .HasMaxLength(80)
            .IsUnicode(false);
    }
}