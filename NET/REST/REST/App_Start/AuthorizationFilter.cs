using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;

namespace REST
{
	public class AuthorizationFilter : AuthorizeAttribute
	{
		public override void OnAuthorization(HttpActionContext actionContext)
		{
			var userName = (string)HttpContext.Current.Items["userName"];

			if (string.IsNullOrEmpty(userName))
				actionContext.Response = actionContext.Request.CreateResponse(HttpStatusCode.Unauthorized);
			else
				HttpContext.Current.Response.AddHeader("AuthenticationStatus", "Authorized");
		}
	}
}
//
//@app.Interceptor(r'/devfest/.*', chainIdx: 0)
//loginFilter() {
//  if (app.request.session["username"] != null)
//    app.chain.next();
//  else
//    app.chain.interrupt(statusCode: HttpStatus.UNAUTHORIZED);
//    //or app.redirect("/login.html");
//}
//
//@app.Interceptor(r'/devfest/.*', chainIdx: 1)
//dbConnInterceptor() {
//  var connection = new DbConn();
//  app.request.attributes["dbConn"] = connection;
//  app.chain.next(() => connection.close());
//}