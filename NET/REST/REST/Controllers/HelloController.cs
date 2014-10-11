using System.Web.Http;

namespace REST.Controllers
{
    public class HelloController : ApiController
	 {
		 [HttpGet]
		 [Route("hello/{name}")]
		 public IHttpActionResult Hello(string name)
		 {
			 return Ok(string.Format("Hello, {0}!", name));
		 }
    }
}

