using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace REST.Controllers
{
	public class ErrorHandlingController : ApiController
	{
		private readonly SpeechRepository speeches;

		public ErrorHandlingController()
		{
			speeches = new SpeechRepository();
		}

		[HttpGet]
		[Route("devfest/speech/{id}")]
		public HttpResponseMessage Get(Guid id)
		{
			var speech = speeches.Get(id);

			if (speech == null)
				throw new EntityNotFoundException();

			return Request.CreateResponse(HttpStatusCode.OK, speech);
		}
	}
}
