using System.Net.Http;
using System.Threading.Tasks;

public class ApiService
{
    private readonly HttpClient httpClient;

    public ApiService(HttpClient httpClient)
    {
        this.httpClient = httpClient;
    }

    public async Task<string> GetApiData()
    {
        // Reemplaza la URL con la de tu API local
        var apiResponse = await httpClient.GetStringAsync("http://localhost:5243/api");
        return apiResponse;
    }
}
