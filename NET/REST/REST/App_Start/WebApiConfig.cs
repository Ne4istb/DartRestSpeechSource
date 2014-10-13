using System.Web.Http;
using REST.App_Start;

namespace REST
{
	public static class WebApiConfig
	{
		public static void Register(HttpConfiguration config)
		{
			config.Filters.Add(new AuthorizationFilter());
			config.Filters.Add(new DbConnInterceptor());
			config.Filters.Add(new NotFoundFilter());
	
			config.MapHttpAttributeRoutes();

			config.Routes.MapHttpRoute(
				 name: "DefaultApi",
				 routeTemplate: "api/{controller}/{id}",
				 defaults: new { id = RouteParameter.Optional }
			);
		}
	}
}
