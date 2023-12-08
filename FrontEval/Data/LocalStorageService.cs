
using System.Threading.Tasks;
using Microsoft.JSInterop;

namespace FrontEval.Data;
public class LocalStorageService
{
    private readonly IJSRuntime _jsRuntime;

    public LocalStorageService(IJSRuntime jsRuntime)
    {
        _jsRuntime = jsRuntime;
    }

    public async Task<string> GetItem(string key)
    {
        return await _jsRuntime.InvokeAsync<string>("localStorage.getItem", key);
    }

    public async Task SetItem(string key, string value)
    {
        await _jsRuntime.InvokeAsync<object>("localStorage.setItem", key, value);
    }

    public async Task RemoveItem(string key)
    {
        await _jsRuntime.InvokeAsync<object>("localStorage.removeItem", key);
    }
}
