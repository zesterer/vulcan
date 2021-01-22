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
	public class Terminal : Vte.Terminal
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public int pid;
		
		public Terminal(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_hexpand(true);
			this.set_vexpand(false);
			
			try
			{
				this.spawn_sync(Vte.PtyFlags.DEFAULT, null, {Vte.get_user_shell()}, null, SpawnFlags.SEARCH_PATH, null, out this.pid);
			}
			catch (Error error)
			{
				this.root.consts.output(error.message);
			}

			Gdk.RGBA background = { 0.15, 0.15, 0.15, 1.0};
			this.set_color_background(background);
		}
	}
}
