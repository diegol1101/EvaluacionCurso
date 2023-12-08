using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Persistence.Data.Migrations
{
    /// <inheritdoc />
    public partial class Initialmigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            /*migrationBuilder.CreateTable(
                name: "departamento",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    nombre = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__departam__3214EC071492D4B3", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "estudiante",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Id_Estudiante = table.Column<int>(type: "int", nullable: true),
                    Nombre = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: false),
                    Apellido = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: false),
                    Edad = table.Column<int>(type: "int", nullable: false),
                    Correo = table.Column<string>(type: "varchar(200)", unicode: false, maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__estudian__3214EC07B80E19D0", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "profesor",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Id_Profesor = table.Column<int>(type: "int", nullable: true),
                    Nombre = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: false),
                    Id_Departamento = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__profesor__3214EC076C533471", x => x.Id);
                    table.ForeignKey(
                        name: "FK__profesor__Id_Dep__3E52440B",
                        column: x => x.Id_Departamento,
                        principalTable: "departamento",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "curso",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nombre = table.Column<string>(type: "varchar(150)", unicode: false, maxLength: 150, nullable: false),
                    Descripcion = table.Column<string>(type: "varchar(300)", unicode: false, maxLength: 300, nullable: false),
                    Fecha_Inicio = table.Column<DateTime>(type: "date", nullable: false),
                    Fecha_Finalizacion = table.Column<DateTime>(type: "date", nullable: false),
                    Evaluacion = table.Column<string>(type: "varchar(120)", unicode: false, maxLength: 120, nullable: false),
                    Id_Estudiante = table.Column<int>(type: "int", nullable: false),
                    Id_Profesor = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__curso__3214EC07FD86C9C6", x => x.Id);
                    table.ForeignKey(
                        name: "FK__curso__Id_Estudi__52593CB8",
                        column: x => x.Id_Estudiante,
                        principalTable: "estudiante",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__curso__Id_Profes__534D60F1",
                        column: x => x.Id_Profesor,
                        principalTable: "profesor",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "calificacion",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nota = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: false),
                    Comentarios = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: true),
                    Id_estudiante = table.Column<int>(type: "int", nullable: false),
                    Id_Curso = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__califica__3214EC071BF1BE6D", x => x.Id);
                    table.ForeignKey(
                        name: "FK__calificac__Id_Cu__571DF1D5",
                        column: x => x.Id_Curso,
                        principalTable: "curso",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__calificac__Id_es__5629CD9C",
                        column: x => x.Id_estudiante,
                        principalTable: "estudiante",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_calificacion_Id_Curso",
                table: "calificacion",
                column: "Id_Curso");

            migrationBuilder.CreateIndex(
                name: "IX_calificacion_Id_estudiante",
                table: "calificacion",
                column: "Id_estudiante");

            migrationBuilder.CreateIndex(
                name: "IX_curso_Id_Estudiante",
                table: "curso",
                column: "Id_Estudiante");

            migrationBuilder.CreateIndex(
                name: "IX_curso_Id_Profesor",
                table: "curso",
                column: "Id_Profesor");

            migrationBuilder.CreateIndex(
                name: "IX_profesor_Id_Departamento",
                table: "profesor",
                column: "Id_Departamento");*/
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            /*migrationBuilder.DropTable(
                name: "calificacion");

            migrationBuilder.DropTable(
                name: "curso");

            migrationBuilder.DropTable(
                name: "estudiante");

            migrationBuilder.DropTable(
                name: "profesor");

            migrationBuilder.DropTable(
                name: "departamento");*/
        }
    }
}
