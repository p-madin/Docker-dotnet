using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using AspNetApp.Models;

namespace AspNetApp.Data;

public class ApplicationDbContext : IdentityDbContext<AppUser, IdentityRole<int>, int>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<AppUser>(entity =>
        {
            entity.ToTable("appUsers");
            
            // Map built-in Identity properties to custom column names
            entity.Property(u => u.Id).HasColumnName("auPK");
            entity.Property(u => u.UserName).HasColumnName("username");
            entity.Property(u => u.NormalizedUserName).HasColumnName("normalized_username");
            entity.Property(u => u.Email).HasColumnName("email");
            entity.Property(u => u.NormalizedEmail).HasColumnName("normalized_email");
            entity.Property(u => u.EmailConfirmed).HasColumnName("email_confirmed");
            entity.Property(u => u.PasswordHash).HasColumnName("password");
            entity.Property(u => u.SecurityStamp).HasColumnName("security_stamp");
            entity.Property(u => u.ConcurrencyStamp).HasColumnName("concurrency_stamp");
            entity.Property(u => u.PhoneNumber).HasColumnName("phone_number");
            entity.Property(u => u.PhoneNumberConfirmed).HasColumnName("phone_number_confirmed");
            entity.Property(u => u.TwoFactorEnabled).HasColumnName("two_factor_enabled");
            entity.Property(u => u.LockoutEnd).HasColumnName("lockout_end");
            entity.Property(u => u.LockoutEnabled).HasColumnName("lockout_enabled");
            entity.Property(u => u.AccessFailedCount).HasColumnName("access_failed_count");
        });

        // Optional: Map other Identity tables if you intend to use roles, etc.
        // builder.Entity<IdentityRole<int>>().ToTable("appRoles");
    }
}
