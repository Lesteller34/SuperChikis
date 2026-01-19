using Microsoft.EntityFrameworkCore;
using ListaSupermercado.Models;

namespace ListaSupermercado.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }
}
