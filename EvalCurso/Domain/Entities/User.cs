using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Domain.Entities;

public class User:BaseEntity
{

    public string Nombre { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }

    /*llaves*/
    public ICollection<Rol> Roles { get; set; } = new HashSet<Rol>();
    public ICollection<RefreshToken> RefreshTokens { get; set; } = new HashSet<RefreshToken>();
    public ICollection<UserRol> UsersRols { get; set; }

}
