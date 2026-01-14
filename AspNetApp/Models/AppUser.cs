using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspNetApp.Models;

[Table("appUsers")]
public class AppUser : IdentityUser<int>
{
    [Key]
    [Column("auPK")]
    public override int Id { get; set; }

    [Required]
    [MaxLength(32)]
    [Column("name")]
    public string Name { get; set; } = string.Empty;

    [Column("age")]
    public int Age { get; set; }

    [Required]
    [MaxLength(32)]
    [Column("city")]
    public string City { get; set; } = string.Empty;

    [Required]
    [MaxLength(16)]
    [Column("username")]
    public override string UserName { get; set; } = string.Empty;

    [Required]
    [MaxLength(32)]
    [Column("email")]
    public override string Email { get; set; } = string.Empty;

    [Column("dateAdded")]
    public DateTime DateAdded { get; set; } = DateTime.Now;

    [Column("dateVerified")]
    public DateTime? DateVerified { get; set; }

    // Mapping Identity password hash to the 'password' column
    // WARNING: VARCHAR(32) is too short for standard Identity hashes.
    [Column("password")]
    public override string PasswordHash { get; set; } = string.Empty;
}
