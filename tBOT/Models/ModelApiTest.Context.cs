﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class tbotEntities : DbContext
    {
        public tbotEntities()
            : base("name=tbotEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<API> APIs { get; set; }
        public virtual DbSet<Api_Config> Api_Config { get; set; }
        public virtual DbSet<Authorization> Authorizations { get; set; }
        public virtual DbSet<Environment> Environments { get; set; }
        public virtual DbSet<Group> Groups { get; set; }
        public virtual DbSet<Group_Config> Group_Config { get; set; }
        public virtual DbSet<Validation> Validations { get; set; }
    }
}
