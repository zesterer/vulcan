namespace EvolveJournal
{
	public class Consts : Object
	{
		public const string name = "Journal";
		public const string comment = "An Evolve OS app to edit your files";
		public const int[] version = {2, 0, 0};
	
		public const bool debug = true;
	
		public const int min_width = 500;
		public const int min_height = 300;
	
		public const int default_width = 800;
		public const int default_height = 600;
		
		public Application application;
		
		public Consts(Application application)
		{
			this.application = application;
		}
	
		public void output(string message, string type = "debug")
		{
			if ((bool.parse(this.application.config.getProperty("debug")) && type == "debug") || type != "debug")
				stdout.printf("[" + type.up() + "] " + message + "\n");
		}
	}
}
