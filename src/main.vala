namespace Journal
{
	public class Application : Gtk.Application
	{
		public Application root;
	
		public Consts consts;
		public Config config;
	
		public Window window;
	
		public Application(string[] args)
		{
			this.root = this;
			
			this.root.consts.output("Starting application...");
			
			this.consts = new Consts(this);
			this.config = new Config(this.consts);
			this.config.dataChanged.connect(this.dataApplicationChanged);
			this.config.setProperty("debug", "true");
			this.config.setProperty("dark-theme", "true");
		
			this.window = new Window(this);
			this.window.show_all();
		}
		
		public void dataApplicationChanged(string name, string data)
		{
			switch (name)
			{
				case ("dark-theme"):
					Gtk.Settings.get_default().set("gtk-application-prefer-dark-theme", bool.parse(data));
					break;
			}
		}
	
		public void close()
		{
			this.root.consts.output("Closing application...");
			Gtk.main_quit();
		}
	}

	int main(string[] args)
	{
		Gtk.init(ref args);
	
		Application application;
		application = new Application(args);
	
		Gtk.main();
	
		return 0;
	}
}
