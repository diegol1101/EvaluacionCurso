using API.Dtos;
using AutoMapper;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;

public class EstudianteController : ApiBaseController
{
    private readonly IUnitOfWork unitofwork;
    private readonly IMapper mapper;

    public EstudianteController(IUnitOfWork unitofwork, IMapper mapper)
    {
        this.unitofwork = unitofwork;
        this.mapper = mapper;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<EstudianteDto>>> Get()
    {
        var estudiante = await unitofwork.Estudiantes.GetAllAsync();
        return mapper.Map<List<EstudianteDto>>(estudiante);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<EstudianteDto>> Get(int id)
    {
        var estudiante = await unitofwork.Estudiantes.GetByIdAsync(id);
        if (estudiante == null)
        {
            return NotFound();
        }
        return this.mapper.Map<EstudianteDto>(estudiante);
    }

    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<Estudiante>> Post(EstudianteDto estudianteDto)
    {
        var estudiante = this.mapper.Map<Estudiante>(estudianteDto);
        this.unitofwork.Estudiantes.Add(estudiante);
        await unitofwork.SaveAsync();
        if (estudiante == null)
        {
            return BadRequest();
        }
        estudianteDto.Id = estudiante.Id;
        return CreatedAtAction(nameof(Post), new { id = estudianteDto.Id }, estudianteDto);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<EstudianteDto>> Put(int id, [FromBody] EstudianteDto estudianteDto)
    {
        if (estudianteDto == null)
        {
            return NotFound();
        }
        var estudiante = this.mapper.Map<Estudiante>(estudianteDto);
        unitofwork.Estudiantes.Update(estudiante);
        await unitofwork.SaveAsync();
        return estudianteDto;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<IActionResult> Delete(int id)
    {
        var estudiante = await unitofwork.Estudiantes.GetByIdAsync(id);
        if (estudiante == null)
        {
            return NotFound();
        }
        unitofwork.Estudiantes.Remove(estudiante);
        await unitofwork.SaveAsync();
        return NoContent();
    }
}
