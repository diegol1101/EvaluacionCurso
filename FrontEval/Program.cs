using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using FrontEval;
using FrontEval.Data;
using System;
using System.Net.Http;
using System.Threading.Tasks;
using FrontEval.Pages;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");
builder.Services.AddScoped<LocalStorageService>();

// Configurar el cliente HTTP para consumir la API local
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });

// Agregar tu servicio para consumir la API local (puedes crear una clase separada para manejar las llamadas a la API)


await builder.Build().RunAsync();
