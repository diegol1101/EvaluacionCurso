using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities;

namespace API.Dtos
{
    public class RolDto:BaseEntity
    {
        public string Nombre { get; set; }
    }
}