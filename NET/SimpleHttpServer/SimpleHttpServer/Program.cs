using System.Net;
using System.Text;

namespace SimpleHttpServer
{
	internal class Program
	{
		private static void Main()
		{
			var listener = new HttpListener();

			listener.Prefixes.Add("http://localhost:8080/");

			listener.Start();

			while (true)
			{
				var context = listener.GetContext(); 
				
				var bytes = Encoding.UTF8.GetBytes("Hello, DevFest from C#!");
				context.Response.OutputStream.Write(bytes, 0, bytes.Length);
				
				context.Response.Close();
			}
		}
	}
}