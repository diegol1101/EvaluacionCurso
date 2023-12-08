using API.Dtos;

using AutoMapper;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;

public class CursoController : ApiBaseController
{
    private readonly IUnitOfWork unitofwork;
    private readonly IMapper mapper;

    public CursoController(IUnitOfWork unitofwork, IMapper mapper)
    {
        this.unitofwork = unitofwork;
        this.mapper = mapper;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<CursoDto>>> Get()
    {
        var curso = await unitofwork.Cursos.GetAllAsync();
        return mapper.Map<List<CursoDto>>(curso);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<CursoDto>> Get(int id)
    {
        var curso = await unitofwork.Cursos.GetByIdAsync(id);
        if (curso == null)
        {
            return NotFound();
        }
        return this.mapper.Map<CursoDto>(curso);
    }

    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<Curso>> Post(CursoDto cursoDto)
    {
        var curso = this.mapper.Map<Curso>(cursoDto);
        this.unitofwork.Cursos.Add(curso);
        await unitofwork.SaveAsync();
        if (curso == null)
        {
            return BadRequest();
        }
        cursoDto.Id = curso.Id;
        return CreatedAtAction(nameof(Post), new { id = cursoDto.Id }, cursoDto);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<CursoDto>> Put(int id, [FromBody] CursoDto cursoDto)
    {
        if (cursoDto == null)
        {
            return NotFound();
        }
        var curso = this.mapper.Map<Curso>(cursoDto);
        unitofwork.Cursos.Update(curso);
        await unitofwork.SaveAsync();
        return cursoDto;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<IActionResult> Delete(int id)
    {
        var curso = await unitofwork.Cursos.GetByIdAsync(id);
        if (curso == null)
        {
            return NotFound();
        }
        unitofwork.Cursos.Remove(curso);
        await unitofwork.SaveAsync();
        return NoContent();
    }

    [HttpGet("TodosLosCursos")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<CursoDto>>> TodosLosCursos()
    {
        var curso = await unitofwork.Cursos.TodosLosCursos();
        return mapper.Map<List<CursoDto>>(curso);
    }

    [HttpGet("ProfesorCursos")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<object>>> ProfesorCursos()
    {
        var curso = await unitofwork.Cursos.ProfesorCursos();
        return mapper.Map<List<object>>(curso);
    }

    [HttpGet("EstudianteCurso")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<object>>> EstudianteCurso()
    {
        var curso = await unitofwork.Cursos.EstudianteCurso();
        return mapper.Map<List<object>>(curso);
    }
}
