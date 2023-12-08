using API.Dtos;

using AutoMapper;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;

public class DepartamentoController : ApiBaseController
{
    private readonly IUnitOfWork unitofwork;
    private readonly IMapper mapper;

    public DepartamentoController(IUnitOfWork unitofwork, IMapper mapper)
    {
        this.unitofwork = unitofwork;
        this.mapper = mapper;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<DepartamentoDto>>> Get()
    {
        var departamento = await unitofwork.Departamentos.GetAllAsync();
        return mapper.Map<List<DepartamentoDto>>(departamento);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<DepartamentoDto>> Get(int id)
    {
        var departamento = await unitofwork.Departamentos.GetByIdAsync(id);
        if (departamento == null)
        {
            return NotFound();
        }
        return this.mapper.Map<DepartamentoDto>(departamento);
    }

    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<Departamento>> Post(DepartamentoDto departamentoDto)
    {
        var departamento = this.mapper.Map<Departamento>(departamentoDto);
        this.unitofwork.Departamentos.Add(departamento);
        await unitofwork.SaveAsync();
        if (departamento == null)
        {
            return BadRequest();
        }
        departamentoDto.Id = departamento.Id;
        return CreatedAtAction(nameof(Post), new { id = departamentoDto.Id }, departamentoDto);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<DepartamentoDto>> Put(int id, [FromBody] DepartamentoDto departamentoDto)
    {
        if (departamentoDto == null)
        {
            return NotFound();
        }
        var departamento = this.mapper.Map<Departamento>(departamentoDto);
        unitofwork.Departamentos.Update(departamento);
        await unitofwork.SaveAsync();
        return departamentoDto;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<IActionResult> Delete(int id)
    {
        var departamento = await unitofwork.Departamentos.GetByIdAsync(id);
        if (departamento == null)
        {
            return NotFound();
        }
        unitofwork.Departamentos.Remove(departamento);
        await unitofwork.SaveAsync();
        return NoContent();
    }
}