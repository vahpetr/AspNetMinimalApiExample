var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/", () => "AspNet minimal API");

app.Run();
