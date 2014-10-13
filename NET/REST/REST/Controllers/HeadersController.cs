using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http;
using System.Web.Http.Results;

namespace REST.Controllers
{
	public class HeadersController : ApiController
	{
		private readonly SpeechRepository speeches;

		public HeadersController()
		{
			speeches = new SpeechRepository();
		}

		[HttpGet]
//		[Route("devfest/speech/{id}")]
		public HttpResponseMessage Get(Guid id)
		{
			var speech = speeches.Get(id);

			var response = Request.CreateResponse(HttpStatusCode.OK, speech);
			
			response.Headers.ETag = new EntityTagHeaderValue("\"" + speech.Version + "\"");
			response.Headers.Add("Access-Control-Allow-Origin", "*");

			return response;
		}
	}
}
