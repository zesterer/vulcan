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
		
		public Gtk.Box title_box;
		public Gtk.Button title_button;
		public FileInfoPopover title_popover;
		public Gtk.Button syntax_button;
		
		public Gtk.Button new_window_button;
		public Gtk.ToggleButton settings_button;
	
		public HeaderBar(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_subtitle(this.root.consts.comment);
			this.set_show_close_button(true);
			
			this.title_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			this.title_box.height_request = 32;
			this.title_box.get_style_context().add_class("linked");
			this.set_custom_title(this.title_box);
			
			this.title_button = new Gtk.Button();
			this.title_box.add(this.title_button);
			
			this.title_popover = new FileInfoPopover(this, this.title_button);
			this.title_button.clicked.connect(this.title_popover.toggleVisible);
			
			this.syntax_button = new Gtk.Button();
			this.title_box.add(this.syntax_button);
			
			this.setTitle(this.root.consts.name);
			this.setSyntax("None");
			
			this.new_window_button = new Gtk.Button();
			this.new_window_button.set_image(new Gtk.Image.from_icon_name("text-editor-symbolic", Gtk.IconSize.MENU));
			this.new_window_button.clicked.connect(this.newWindowButtonClicked);
			this.new_window_button.set_tooltip_text("Open a new window [Ctrl+W]");
			this.pack_start(this.new_window_button);
			
			this.settings_button = new Gtk.ToggleButton();
			this.settings_button.set_tooltip_text("Toggle the settings bar visibility [Ctrl+P]");
			this.settings_button.set_image(new Gtk.Image.from_icon_name("open-menu-symbolic", Gtk.IconSize.MENU));
			this.settings_button.clicked.connect(this.settingsBarButtonClicked);
			this.pack_end(this.settings_button);
			
			this.window.config.dataChanged.connect(this.dataWindowChanged);
		}
		
		public void dataWindowChanged(string name, string data)
		{
			switch (name)
			{
				case ("show-settingsbar"):
					this.settings_button.set_active(bool.parse(data));
					break;
			}
		}
		
		public void settingsBarButtonClicked()
		{
			this.window.config.setProperty("show-settingsbar", this.settings_button.get_active().to_string());
		}
		public void newWindowButtonClicked()
		{
			this.root.addWindow();
		}
		
		public void setTitle(string title)
		{
			this.title_button.set_label(title);
		}
		
		public void setSyntax(string syntax)
		{
			this.syntax_button.set_label(syntax);
		}
		
		public void setSubtitle(string subtitle)
		{
			this.title_button.set_label(subtitle);
		}
		
		public void tabSwitched()
		{
			TabBox? tab = this.window.source_stack.getCurrentTab();
			
			if (tab == null)
			{
				this.setTitle(this.root.consts.name);
				this.setSyntax("None");
				this.set_subtitle(this.root.consts.comment);
			}
			else
			{
				string title = tab.filename;
				string syntax = "None";
				if (tab.language != null)
					syntax = tab.language;
				
				this.setTitle(title);
				this.setSyntax(syntax);
				if (tab.file == null)
					this.set_subtitle("Unknown location");
				else
					this.set_subtitle(tab.file.get_path());
			}
			
			this.title_popover.update();
		}
	}
}
