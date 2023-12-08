using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Domain.Entities;

public class UserRol
{

    /*llaves*/
        public int UserIdFk {get; set;}
        public User User {get; set;}

        public int RolIdFk {get; set;}
        public Rol Rol {get; set;}


}
