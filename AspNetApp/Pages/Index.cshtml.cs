using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using AspNetApp.Data;
using AspNetApp.Models;

namespace AspNetApp.Pages;

public class IndexModel : PageModel
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<IndexModel> _logger;

    public IndexModel(ApplicationDbContext context, ILogger<IndexModel> logger)
    {
        _context = context;
        _logger = logger;
    }

    public List<string> UserNames { get; set; } = new();

    public async Task OnGetAsync()
    {
        UserNames = await _context.Users
            .Select(u => u.Name)
            .ToListAsync();
    }
}
