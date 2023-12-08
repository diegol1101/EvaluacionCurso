﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Persistence;

#nullable disable

namespace Persistence.Data.Migrations
{
    [DbContext(typeof(DbAppContext))]
    [Migration("20231203045037_secondmigration")]
    partial class Secondmigration
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("Domain.Entities.Calificacion", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Comentarios")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)");

                    b.Property<int>("IdCurso")
                        .HasColumnType("int")
                        .HasColumnName("Id_Curso");

                    b.Property<int>("IdEstudiante")
                        .HasColumnType("int")
                        .HasColumnName("Id_estudiante");

                    b.Property<string>("Nota")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)");

                    b.HasKey("Id")
                        .HasName("PK__califica__3214EC071BF1BE6D");

                    b.HasIndex("IdCurso");

                    b.HasIndex("IdEstudiante");

                    b.ToTable("calificacion", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.Curso", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Descripcion")
                        .HasMaxLength(300)
                        .IsUnicode(false)
                        .HasColumnType("varchar(300)");

                    b.Property<string>("Evaluacion")
                        .HasMaxLength(120)
                        .IsUnicode(false)
                        .HasColumnType("varchar(120)");

                    b.Property<DateTime>("FechaFinalizacion")
                        .HasColumnType("date")
                        .HasColumnName("Fecha_Finalizacion");

                    b.Property<DateTime>("FechaInicio")
                        .HasColumnType("date")
                        .HasColumnName("Fecha_Inicio");

                    b.Property<int>("IdEstudiante")
                        .HasColumnType("int")
                        .HasColumnName("Id_Estudiante");

                    b.Property<int>("IdProfesor")
                        .HasColumnType("int")
                        .HasColumnName("Id_Profesor");

                    b.Property<string>("Nombre")
                        .HasMaxLength(150)
                        .IsUnicode(false)
                        .HasColumnType("varchar(150)");

                    b.HasKey("Id")
                        .HasName("PK__curso__3214EC07FD86C9C6");

                    b.HasIndex("IdEstudiante");

                    b.HasIndex("IdProfesor");

                    b.ToTable("curso", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.Departamento", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Nombre")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)")
                        .HasColumnName("nombre");

                    b.HasKey("Id")
                        .HasName("PK__departam__3214EC071492D4B3");

                    b.ToTable("departamento", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.Estudiante", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Apellido")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)");

                    b.Property<string>("Correo")
                        .HasMaxLength(200)
                        .IsUnicode(false)
                        .HasColumnType("varchar(200)");

                    b.Property<int>("Edad")
                        .HasColumnType("int");

                    b.Property<int?>("IdEstudiante")
                        .HasColumnType("int")
                        .HasColumnName("Id_Estudiante");

                    b.Property<string>("Nombre")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)");

                    b.HasKey("Id")
                        .HasName("PK__estudian__3214EC07B80E19D0");

                    b.ToTable("estudiante", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.Profesor", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("IdDepartamento")
                        .HasColumnType("int")
                        .HasColumnName("Id_Departamento");

                    b.Property<int?>("IdProfesor")
                        .HasColumnType("int")
                        .HasColumnName("Id_Profesor");

                    b.Property<string>("Nombre")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)");

                    b.HasKey("Id")
                        .HasName("PK__profesor__3214EC076C533471");

                    b.HasIndex("IdDepartamento");

                    b.ToTable("profesor", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.RefreshToken", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Created")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("Expires")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("Revoked")
                        .HasColumnType("datetime2");

                    b.Property<string>("Token")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("RefreshToken", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.Rol", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar")
                        .HasColumnName("rolName");

                    b.HasKey("Id");

                    b.ToTable("rol", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("varchar")
                        .HasColumnName("email");

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar")
                        .HasColumnName("username");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("varchar")
                        .HasColumnName("password");

                    b.HasKey("Id");

                    b.ToTable("user", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.UserRol", b =>
                {
                    b.Property<int>("UserIdFk")
                        .HasColumnType("int");

                    b.Property<int>("RolIdFk")
                        .HasColumnType("int");

                    b.HasKey("UserIdFk", "RolIdFk");

                    b.HasIndex("RolIdFk");

                    b.ToTable("userRol", (string)null);
                });

            modelBuilder.Entity("Domain.Entities.Calificacion", b =>
                {
                    b.HasOne("Domain.Entities.Curso", "IdCursoNavigation")
                        .WithMany("Calificacions")
                        .HasForeignKey("IdCurso")
                        .IsRequired()
                        .HasConstraintName("FK__calificac__Id_Cu__571DF1D5");

                    b.HasOne("Domain.Entities.Estudiante", "IdEstudianteNavigation")
                        .WithMany("Calificacions")
                        .HasForeignKey("IdEstudiante")
                        .IsRequired()
                        .HasConstraintName("FK__calificac__Id_es__5629CD9C");

                    b.Navigation("IdCursoNavigation");

                    b.Navigation("IdEstudianteNavigation");
                });

            modelBuilder.Entity("Domain.Entities.Curso", b =>
                {
                    b.HasOne("Domain.Entities.Estudiante", "IdEstudianteNavigation")
                        .WithMany("Cursos")
                        .HasForeignKey("IdEstudiante")
                        .IsRequired()
                        .HasConstraintName("FK__curso__Id_Estudi__52593CB8");

                    b.HasOne("Domain.Entities.Profesor", "IdProfesorNavigation")
                        .WithMany("Cursos")
                        .HasForeignKey("IdProfesor")
                        .IsRequired()
                        .HasConstraintName("FK__curso__Id_Profes__534D60F1");

                    b.Navigation("IdEstudianteNavigation");

                    b.Navigation("IdProfesorNavigation");
                });

            modelBuilder.Entity("Domain.Entities.Profesor", b =>
                {
                    b.HasOne("Domain.Entities.Departamento", "IdDepartamentoNavigation")
                        .WithMany("Profesors")
                        .HasForeignKey("IdDepartamento")
                        .IsRequired()
                        .HasConstraintName("FK__profesor__Id_Dep__3E52440B");

                    b.Navigation("IdDepartamentoNavigation");
                });

            modelBuilder.Entity("Domain.Entities.RefreshToken", b =>
                {
                    b.HasOne("Domain.Entities.User", "User")
                        .WithMany("RefreshTokens")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("Domain.Entities.UserRol", b =>
                {
                    b.HasOne("Domain.Entities.Rol", "Rol")
                        .WithMany("UsersRols")
                        .HasForeignKey("RolIdFk")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Domain.Entities.User", "User")
                        .WithMany("UsersRols")
                        .HasForeignKey("UserIdFk")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Rol");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Domain.Entities.Curso", b =>
                {
                    b.Navigation("Calificacions");
                });

            modelBuilder.Entity("Domain.Entities.Departamento", b =>
                {
                    b.Navigation("Profesors");
                });

            modelBuilder.Entity("Domain.Entities.Estudiante", b =>
                {
                    b.Navigation("Calificacions");

                    b.Navigation("Cursos");
                });

            modelBuilder.Entity("Domain.Entities.Profesor", b =>
                {
                    b.Navigation("Cursos");
                });

            modelBuilder.Entity("Domain.Entities.Rol", b =>
                {
                    b.Navigation("UsersRols");
                });

            modelBuilder.Entity("Domain.Entities.User", b =>
                {
                    b.Navigation("RefreshTokens");

                    b.Navigation("UsersRols");
                });
#pragma warning restore 612, 618
        }
    }
}
