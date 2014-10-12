using System;
using System.Net;
using System.Net.Http;
using System.Web.Http.Filters;

namespace REST
{
	public class NotFoundFilter : ExceptionFilterAttribute
	{
		public override void OnException(HttpActionExecutedContext context)
		{
			var exception = context.Exception;

			if (exception is EntityNotFoundException)
			{
				//process exception
				context.Response = context.Request.CreateResponse(HttpStatusCode.NotFound, exception.Message);
			}
		}
	}

	public class EntityNotFoundException : Exception
	{ }
}