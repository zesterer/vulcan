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
	public class HeaderBar : Gtk.HeaderBar
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public Gtk.ToggleButton settings_button;
	
		public HeaderBar(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
		
			this.set_title(this.root.consts.name);
			this.set_subtitle(this.root.consts.comment);
			this.set_show_close_button(true);
			
			this.settings_button = new Gtk.ToggleButton();
			this.settings_button.set_image(new Gtk.Image.from_icon_name("open-menu-symbolic", Gtk.IconSize.MENU));
			this.settings_button.clicked.connect(this.settingsBarButtonClicked);
			this.pack_end(this.settings_button);
		}
		
		public void settingsBarButtonClicked()
		{
			this.window.config.setProperty("show-settingsbar", this.settings_button.get_active().to_string());
		}
		
		public void tabSwitched()
		{
			TabBox? tab = this.window.source_stack.getCurrentTab();
			
			if (tab == null)
			{
				this.set_title(this.root.consts.name);
				this.set_subtitle(this.root.consts.comment);
			}
			else
			{
				string title = tab.filename;
				if (tab.language != null)
					title += " [" + tab.language + "]";
				
				this.set_title(title);
				if (tab.file == null)
					this.set_subtitle("Unknown location");
				else
					this.set_subtitle(tab.file.get_path());
			}
		}
	}
}
