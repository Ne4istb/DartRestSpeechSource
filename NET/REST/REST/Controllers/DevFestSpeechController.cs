using System;
using System.Web.Http;

namespace REST.Controllers
{
	public class DevFestSpeechController : ApiController
	{
		private readonly SpeechRepository speeches;

		public DevFestSpeechController()
		{
			speeches = new SpeechRepository();
		}

		[HttpGet]
		[Route("devfest/speech/{id}")]
		public Speech Get(Guid id)
		{
			return speeches.Get(id);
		}

		[HttpPost]
		[Route("devfest/speech")]
		public void Post([FromBody]Speech speech)
		{
			speeches.Add(speech);
		}

		[HttpPut]
		[Route("devfest/speech/{id}")]
		public void Put(Guid id, [FromBody]Speech speech)
		{
			speeches.Update(id, speech);
		}

		[HttpDelete]
		[Route("devfest/speech/{id}")]
		public void Delete(Guid id)
		{
			speeches.Delete(id);
		}
	}

	public class SpeechRepository
	{
		public Speech Get(Guid id)
		{
			return new Speech()
			{
				Version = 5
			};
		}

		public void Add(Speech speech)
		{
			throw new NotImplementedException();
		}

		public void Delete(Guid id)
		{
			throw new NotImplementedException();
		}

		public void Update(Guid id, Speech speech)
		{
			throw new NotImplementedException();
		}
	}

	public class Speech
	{
		public int Version { get; set; }
	}
}
