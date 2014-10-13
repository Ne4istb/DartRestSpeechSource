using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace REST.App_Start
{
	public class DbConnInterceptor: ActionFilterAttribute
	{
		public override void OnActionExecuting(HttpActionContext actionContext)
		{
			var dbConn = new DbConn(); 
			dbConn.Open();

			base.OnActionExecuting(actionContext);
		}

		public override void OnActionExecuted(HttpActionExecutedContext actionExecutedContext)
		{
			var dbConn = (DbConn)HttpContext.Current.Items["DbConn"];
			dbConn.Close();

			base.OnActionExecuted(actionExecutedContext);
		}
	}

	public class DbConn
	{
		public void Open()
		{}

		public void Close()
		{}
	}
}