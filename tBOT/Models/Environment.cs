//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace tBOT.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Environment
    {
        public int Id { get; set; }
        public string AppServer { get; set; }
        public Nullable<int> AppPort { get; set; }
        public string DBHostName { get; set; }
        public Nullable<int> DBPortNumber { get; set; }
        public string DBServiceName { get; set; }
        public string DBUserId { get; set; }
        public string DBPassword { get; set; }
    }
}
