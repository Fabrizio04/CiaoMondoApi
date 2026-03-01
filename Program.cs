var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World! La pipeline è un successo! 🚀");

app.Run();
