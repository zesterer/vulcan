namespace Journal
{
	public class Consts : Object
	{
		public string name = "Journal";
		public string comment = "A Gtk app to edit your files";
		public int[] version = {2, 0, 0};
	
		public int min_width = 500;
		public int min_height = 300;
	
		public int default_width = 800;
		public int default_height = 600;
		
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
