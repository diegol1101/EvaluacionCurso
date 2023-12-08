using API.Dtos;

using AutoMapper;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;

public class ProfesorController : ApiBaseController
{
    private readonly IUnitOfWork unitofwork;
    private readonly IMapper mapper;

    public ProfesorController(IUnitOfWork unitofwork, IMapper mapper)
    {
        this.unitofwork = unitofwork;
        this.mapper = mapper;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<ProfesorDto>>> Get()
    {
        var profesor = await unitofwork.Profesores.GetAllAsync();
        return mapper.Map<List<ProfesorDto>>(profesor);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<ProfesorDto>> Get(int id)
    {
        var profesor = await unitofwork.Profesores.GetByIdAsync(id);
        if (profesor == null)
        {
            return NotFound();
        }
        return this.mapper.Map<ProfesorDto>(profesor);
    }

    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<Profesor>> Post(ProfesorDto profesorDto)
    {
        var profesor = this.mapper.Map<Profesor>(profesorDto);
        this.unitofwork.Profesores.Add(profesor);
        await unitofwork.SaveAsync();
        if (profesor == null)
        {
            return BadRequest();
        }
        profesorDto.Id = profesor.Id;
        return CreatedAtAction(nameof(Post), new { id = profesorDto.Id }, profesorDto);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<ProfesorDto>> Put(int id, [FromBody] ProfesorDto profesorDto)
    {
        if (profesorDto == null)
        {
            return NotFound();
        }
        var profesor = this.mapper.Map<Profesor>(profesorDto);
        unitofwork.Profesores.Update(profesor);
        await unitofwork.SaveAsync();
        return profesorDto;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<IActionResult> Delete(int id)
    {
        var profesor = await unitofwork.Profesores.GetByIdAsync(id);
        if (profesor == null)
        {
            return NotFound();
        }
        unitofwork.Profesores.Remove(profesor);
        await unitofwork.SaveAsync();
        return NoContent();
    }

    [HttpGet("ProfesorDpto")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<object>>> ProfesorDpto()
    {
        var profesor = await unitofwork.Profesores.ProfesorDpto();
        return mapper.Map<List<object>>(profesor);
    }
}
