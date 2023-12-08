# Evaluación de Curso

Este proyecto aborda la problemática del desarrollo de una página web para gestionar cursos, estudiantes, profesores y notas en un establecimiento educativo. La solución se divide en dos partes:

## Frontend

Desarrollado en Blazor, el frontend consta de los siguientes módulos:

### LogIn
**Funcionalidad:** Valida al usuario mediante JSON Web Token para determinar la existencia del usuario.

![LogIn](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/7ba27f33-cfef-4b86-978c-df1b07bc882b)

### Cursos Actuales
**Funcionalidad:** Permite visualizar, agregar y eliminar cursos en la base de datos. Estos cursos pueden estar relacionados con estudiantes y profesores.

![Cursos Actuales](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/a7928e26-dc24-4374-91c3-521d77ff7174)

### Estudiantes
**Funcionalidad:** Visualiza datos de estudiantes y facilita la adición y eliminación de los mismos.

![Estudiantes](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/71ebbd3b-9fdc-483c-a018-28efe065a521)

### Calificaciones
**Funcionalidad:** Permite agregar calificaciones a estudiantes, con la opción de añadir comentarios sobre el estudiante o el curso.

![Calificaciones](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/d7300d5c-92ff-40f7-9ed5-b00e1d60047f)

### Profesores
**Funcionalidad:** Facilita la adición y visualización de profesores.

![Profesores](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/03ff24dc-17c2-41ea-9977-4a62ce7485fe)

## Backend

Desarrollado en C#, .NET y Entity Framework con SQL Server, el backend gestiona las operaciones en la base de datos. Todas las tablas cuentan con métodos para listar, agregar, editar, eliminar y eliminar por ID. Además, se han creado endpoints personalizados:

### Calificacion

- Calificaciones de estudiantes: [CalificacionEstudiante](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/57c1ea65-9e25-4ea5-9d22-580e5d94a419)

### Curso

- Todos los cursos: [TodosLosCursos](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/82693992-803e-461c-864f-17991fdb2bd9)
- Profesores de los cursos: [ProfesorCursos](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/f4a7076f-7fd4-4e57-a441-b865c230774e)
- Estudiantes de los cursos: [EstudianteCurso](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/34ae4a18-cd52-4442-bdcb-5f56fa53b3fb)

### Profesor

- Departamentos de los profesores: [ProfesorDpto](https://github.com/diegol1101/EvaluacionCurso/assets/116105368/93d82c30-c0d5-43d0-bb9c-088eeddbf386)












