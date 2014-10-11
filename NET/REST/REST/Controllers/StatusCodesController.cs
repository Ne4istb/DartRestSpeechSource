using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace REST.Controllers
{
	public class StatusCodesController : ApiController
	{
		private readonly SpeechRepository speeches;

		public StatusCodesController()
		{
			speeches = new SpeechRepository();
		}

		public IHttpActionResult Get(Guid id)
		{
			return Ok(speeches.Get(id));
		}

		public IHttpActionResult Post([FromBody]Speech speech)
		{
			speeches.Add(speech);
			return Created<Speech>(new Uri("some_new_url"), null);
		}

	}

	public class StatusCodes2Controller : ApiController
	{
		private readonly SpeechRepository speeches;

		public StatusCodes2Controller()
		{
			speeches = new SpeechRepository();
		}

		public HttpResponseMessage Get(Guid id)
		{
			return Request.CreateResponse(HttpStatusCode.OK, speeches.Get(id));
		}

		public HttpResponseMessage Post([FromBody]Speech speech)
		{
			speeches.Add(speech);
			return Request.CreateResponse(HttpStatusCode.Created);
		}

	}
}
