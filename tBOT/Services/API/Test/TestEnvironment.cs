
namespace tBOT.Services.API.Test
{
    public class TestEnvironment
    {
        public ApplicationEnvironment App { get; set; }
        public DataBaseBEnvironment DB { get; set; }

    }

    public class ApplicationEnvironment
    {
        public string Server { get; set; }
    }

    public class DataBaseBEnvironment
    {
        public string HostName { get; set; }
        public string PortNumber { get; set; }
        public string ServiceName { get; set; }
        public string UserId { get; set; }
        public string Password { get; set; }
    }

}