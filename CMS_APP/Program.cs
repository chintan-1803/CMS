using CMS.ApplicationHelpers;
using CMS.Constants;
using CMS.Interfaces;
using CMS.Services;

var builder = WebApplication.CreateBuilder(args);

//Add session and cookie in .net core application
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.Cookie.Name = ".TechcronusCMS.Session";
    options.IdleTimeout = TimeSpan.FromDays(7);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

//------ Add services for refreshing view page after any change at runtime.
builder.Services.AddControllersWithViews().AddRazorRuntimeCompilation();

//------ Get base url from the configuration file for redirect to CRM Web Api project.
WebApiRelativeURLs.BaseURL = builder.Configuration.GetValue<string>("WebApiUrl");

//------ Add Httpcontext into the pipeline.
builder.Services.AddHttpContextAccessor();


//------ Add services to pipeline also called as dependancy injection
builder.Services.AddSingleton<HttpContextAccessor>();
builder.Services.AddScoped<IUserService,UserService>();
builder.Services.AddScoped<IDesignation,Designation>();
builder.Services.AddScoped<IReason,Reason>();
builder.Services.AddScoped<IRole,Role>();
builder.Services.AddScoped<IRound, Round>();
builder.Services.AddScoped<ITechnology,Technology>();
builder.Services.AddScoped<IMasterData,MasterData>();

builder.Services.AddScoped<IInterviewer, Interviewer>();





var app = builder.Build();


// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseSession();
app.UseRouting();

app.UseAuthorization();


app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Login}/{action=Login}/{id?}");

app.Run();
