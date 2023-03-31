using Serilog;
using Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Services;
using CMSWebApi.DataHelper;
using CMS.Models;
using CMSWebApi.Dapper;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// add services to DI container
//var services = builder.Services;

Log.Logger = new LoggerConfiguration().CreateBootstrapLogger();
builder.Host.UseSerilog(((ctx, lc) => lc
.ReadFrom.Configuration(ctx.Configuration)));


builder.Services.AddCors();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddControllers()
    .AddJsonOptions(opts => opts.JsonSerializerOptions.PropertyNamingPolicy = null);

// configure DI for application services
builder.Services.AddSingleton<HttpContextAccessor>();
builder.Services.AddScoped<IUserApiService,UserApiService>();
builder.Services.AddScoped<IDesignation_Interface,Designation_Service>();
builder.Services.AddScoped<IReason_Interface,Reason_Service>();
builder.Services.AddScoped<IRole_Interface,Role_Service>();
builder.Services.AddScoped<IRound_Interface,Round_Service>();
builder.Services.AddScoped<ITechnology_Interface,Technology_Service>();
builder.Services.AddScoped<IDapper,Dappers>();
builder.Services.AddScoped<ICipherService,CipherService>();
builder.Services.AddScoped<IInterviewer_Interface, Interviewer_Service>();




builder.Services.Configure<AppSettings>(builder.Configuration.GetSection("AppSettings"));
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Candidate Management System", Version = "v1" });
});

var app = builder.Build();


app.UseSwagger(c =>
{
    c.RouteTemplate = "WebApi/swagger/{documentname}/swagger.json";
});


app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/WebApi/swagger/v1/swagger.json","");
    c.RoutePrefix = "WebApi/swagger";
});

app.UseSerilogRequestLogging();

//// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
//    app.UseSwagger();
//    app.UseSwaggerUI();
//}




// configure HTTP request pipeline
{
    // global cors policy
    app.UseCors(x => x
        .AllowAnyOrigin()
        .AllowAnyMethod()
        .AllowAnyHeader());

    // custom jwt auth middleware
    app.UseMiddleware<JwtMiddleware>();

    app.MapControllers();
}


app.Run();
