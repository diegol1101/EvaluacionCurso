using API.Dtos;

using AutoMapper;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;

public class CalificacionController : ApiBaseController
{
    private readonly IUnitOfWork unitofwork;
    private readonly IMapper mapper;

    public CalificacionController(IUnitOfWork unitofwork, IMapper mapper)
    {
        this.unitofwork = unitofwork;
        this.mapper = mapper;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<CalificacionDto>>> Get()
    {
        var calificacion = await unitofwork.Calificaciones.GetAllAsync();
        return mapper.Map<List<CalificacionDto>>(calificacion);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<CalificacionDto>> Get(int id)
    {
        var calificacion = await unitofwork.Calificaciones.GetByIdAsync(id);
        if (calificacion == null)
        {
            return NotFound();
        }
        return this.mapper.Map<CalificacionDto>(calificacion);
    }

    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<Calificacion>> Post(CalificacionDto calificacionDto)
    {
        var calificacion = this.mapper.Map<Calificacion>(calificacionDto);
        this.unitofwork.Calificaciones.Add(calificacion);
        await unitofwork.SaveAsync();
        if (calificacion == null)
        {
            return BadRequest();
        }
        calificacionDto.Id = calificacion.Id;
        return CreatedAtAction(nameof(Post), new { id = calificacionDto.Id }, calificacionDto);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<CalificacionDto>> Put(int id, [FromBody] CalificacionDto calificacionDto)
    {
        if (calificacionDto == null)
        {
            return NotFound();
        }
        var calificacion = this.mapper.Map<Calificacion>(calificacionDto);
        unitofwork.Calificaciones.Update(calificacion);
        await unitofwork.SaveAsync();
        return calificacionDto;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<IActionResult> Delete(int id)
    {
        var calificacion = await unitofwork.Calificaciones.GetByIdAsync(id);
        if (calificacion == null)
        {
            return NotFound();
        }
        unitofwork.Calificaciones.Remove(calificacion);
        await unitofwork.SaveAsync();
        return NoContent();
    }

    [HttpGet("CalificacionEstudiante")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<object>>> CalificacionEstudiante()
    {
        var calificacion = await unitofwork.Calificaciones.CalificacionEstudiante();
        return mapper.Map<List<object>>(calificacion);
    }
}