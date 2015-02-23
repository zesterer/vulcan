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
	public class Consts : Object
	{
		public string name = "Vulcan";
		public string comment = "A Gtk app to edit your text files";
		public int[] version = {0, 1, 0};
		public string version_string;
	
		public int min_width = 600;
		public int min_height = 400;
	
		public int default_width = 800;
		public int default_height = 600;
		
		public Application application;
		
		public Consts(Application application)
		{
			this.application = application;
			
			this.version_string = @"$(this.version[0]).$(this.version[1])";
		}
	
		public void output(string message, string type = "debug")
		{
			if ((bool.parse(this.application.config.getProperty("debug")) && type == "debug") || type != "debug")
				stdout.printf("[" + type.up() + "] " + message + "\n");
		}
	}
}
