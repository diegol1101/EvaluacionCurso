using Microsoft.EntityFrameworkCore;
using Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace Persistence.Data.Configuration;

public class ProfesorConfiguration : IEntityTypeConfiguration<Profesor>
{
    public void Configure(EntityTypeBuilder<Profesor> builder)
    {
        builder.HasKey(e => e.Id).HasName("PK__profesor__3214EC076C533471");

        builder.ToTable("profesor");

        builder.Property(e => e.IdDepartamento).HasColumnName("Id_Departamento");
        builder.Property(e => e.IdProfesor).HasColumnName("Id_Profesor");
        builder.Property(e => e.Nombre)
            .HasMaxLength(80)
            .IsUnicode(false);

        builder.HasOne(d => d.IdDepartamentoNavigation).WithMany(p => p.Profesors)
            .HasForeignKey(d => d.IdDepartamento)
            .OnDelete(DeleteBehavior.ClientSetNull)
            .HasConstraintName("FK__profesor__Id_Dep__3E52440B");
    }
}