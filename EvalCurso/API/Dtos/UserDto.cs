using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities;

namespace API.Dtos
{
    public class UserDto:BaseEntity
    {
        public string Nombre {get; set;} 
        public string Email {get; set;}
        public string Password {get; set;}
    }
}