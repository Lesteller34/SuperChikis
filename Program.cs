using Microsoft.EntityFrameworkCore;
using SuperChikis2.Data;

var builder = WebApplication.CreateBuilder(args);

// Configurar para escuchar en el puerto 8080 (requerido por Easypanel)
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(8080);
});

// 1. Agrega los controladores con vistas
builder.Services.AddControllersWithViews();

// 2. Configura la conexión (fíjate en la 'g' de UseNpgsql)
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(connectionString));

var app = builder.Build();

// 3. Configuración básica (sin Identity)
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // Agregar HSTS para producción
    app.UseHsts();
}

// Redirección HTTPS (comentado porque Easypanel maneja HTTPS)
// app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Productos}/{action=Index}/{id?}");

app.Run();
