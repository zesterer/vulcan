/* Copyright 2015 Barry Smith
*
* This file is part of Vulcan.
*
* Vulcan is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 2 of the
* License, or (at your option) any later version.
*
* Vulcan is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Vulcan. If not, see http://www.gnu.org/licenses/.
*/

namespace Vulcan
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
