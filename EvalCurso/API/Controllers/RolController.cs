using API.Dtos;

using AutoMapper;
using Domain.Entities;
using Domain.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;
[Authorize]

    public class RolController : ApiBaseController
{
    private readonly IUnitOfWork unitofwork;
    private readonly IMapper mapper;

    public RolController(IUnitOfWork unitofwork, IMapper mapper)
    {
        this.unitofwork = unitofwork;
        this.mapper = mapper;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<IEnumerable<RolDto>>> Get()
    {
        var rol = await unitofwork.Roles.GetAllAsync();
        return mapper.Map<List<RolDto>>(rol);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<RolDto>> Get(int id)
    {
        var rol = await unitofwork.Roles.GetByIdAsync(id);
        if (rol == null)
        {
            return NotFound();
        }
        return this.mapper.Map<RolDto>(rol);
    }
    
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]

    public async Task<ActionResult<Rol>> Post(RolDto rolDto)
    {
        var rol = this.mapper.Map<Rol>(rolDto);
        this.unitofwork.Roles.Add(rol);
        await unitofwork.SaveAsync();
        if (rol == null)
        {
            return BadRequest();
        }
        rolDto.Id = rol.Id;
        return CreatedAtAction(nameof(Post), new { id = rolDto.Id }, rolDto);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<ActionResult<RolDto>> Put(int id, [FromBody] RolDto rolDto)
    {
        if (rolDto == null)
        {
            return NotFound();
        }
        var rol = this.mapper.Map<Rol>(rolDto);
        unitofwork.Roles.Update(rol);
        await unitofwork.SaveAsync();
        return rolDto;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]

    public async Task<IActionResult> Delete(int id)
    {
        var rol = await unitofwork.Roles.GetByIdAsync(id);
        if (rol == null)
        {
            return NotFound();
        }
        unitofwork.Roles.Remove(rol);
        await unitofwork.SaveAsync();
        return NoContent();
    }
    
        
    }