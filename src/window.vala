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
	public class Window : Gtk.Window
	{
		public Application root;
		public Application mother;
		public Window window;
		
		public Config config;
	
		public HeaderBar header_bar;
		
		public Gtk.Box main_box;
		public Gtk.Revealer sidebar_revealer;
		public SideBar sidebar;
		public FileBar filebar;
		public Gtk.Box centre_box;
		public Gtk.Overlay source_stack_overlay;
		public SourceStack source_stack;
		public Gtk.Revealer terminal_revealer;
		public Gtk.ScrolledWindow terminal_scrolled_window;
		public Terminal terminal;
		public Gtk.Revealer settingsbar_revealer;
		public SettingsBar settingsbar;
	
		public Window(Application mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this;
			
			this.config = new Config(this.root.consts);
			this.config.setProperty("line-numbers", "true");
			this.config.setProperty("text-wrap", "false");
			this.config.setProperty("scheme", "solarized-dark");
			this.config.setProperty("show-terminal", "false");
			this.config.setProperty("show-sidebar", "false");
			this.config.setProperty("show-settingsbar", "false");
		
			this.set_size_request(this.root.consts.min_width, this.root.consts.min_height);
			this.set_default_size(this.root.consts.default_width, this.root.consts.default_height);
			this.destroy.connect(this.quit);
		
			this.header_bar = new HeaderBar(this);
			//this.add(this.header_bar);
			this.set_titlebar(this.header_bar);
			//this.header_bar.set_opacity(0.3f);
			//this.header_bar.set_vexpand(false);
			
			this.main_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			this.add(this.main_box);
			
			this.sidebar_revealer = new Gtk.Revealer();
			this.sidebar_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_RIGHT);
			this.main_box.add(this.sidebar_revealer);
			
			this.sidebar = new SideBar(this);
			this.sidebar_revealer.add(this.sidebar);
			
			this.filebar = new FileBar(this);
			this.main_box.add(this.filebar);
		
			this.centre_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			this.main_box.add(this.centre_box);
		
			this.source_stack_overlay = new Gtk.Overlay();
			this.centre_box.add(this.source_stack_overlay);
		
			this.source_stack = new SourceStack(this);
			this.source_stack_overlay.add(this.source_stack);
			
			//Connect the headerbar
			this.source_stack.hasSwitched.connect(this.header_bar.tabSwitched);
			
			this.terminal_revealer = new Gtk.Revealer();
			this.terminal_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_UP);
			this.centre_box.add(this.terminal_revealer);
			
			this.terminal_scrolled_window = new Gtk.ScrolledWindow(null, null);
			this.terminal_scrolled_window.height_request = 200;
			this.terminal_scrolled_window.set_hexpand(false);
			//this.terminal_scrolled_window.set_shadow_type(Gtk.ShadowType.ETCHED_OUT);
			this.terminal_revealer.add(this.terminal_scrolled_window);
			
			this.terminal = new Terminal(this);
			this.terminal_scrolled_window.add(this.terminal);
			
			this.settingsbar_revealer = new Gtk.Revealer();
			this.settingsbar_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_LEFT);
			this.settingsbar_revealer.set_halign(Gtk.Align.END);
			this.source_stack_overlay.add_overlay(this.settingsbar_revealer);
			
			this.settingsbar = new SettingsBar(this);
			this.settingsbar_revealer.add(this.settingsbar);
			
			this.config.dataChanged.connect(this.dataWindowChanged);
			
			//All created, now show it
			this.show_all();
			
			this.key_press_event.connect(this.pressKey);
                    
		}
		
		public void quit()
		{
			this.root.windows.remove(this);
			this.root.close();
			this.destroy();
		}
		
		public void showSideBar(bool show)
		{
			this.sidebar_revealer.set_reveal_child(show);
			
			//Used for switching the icon
			if (this.sidebar_revealer.get_child_revealed())
				this.filebar.sidebar_button.set_image(new Gtk.Image.from_icon_name("pane-hide-symbolic", Gtk.IconSize.MENU));
			else
				this.filebar.sidebar_button.set_image(new Gtk.Image.from_icon_name("pane-show-symbolic", Gtk.IconSize.MENU));
		}
		
		public void dataWindowChanged(string name, string data)
		{
			switch (name)
			{
				case ("show-terminal"):
					this.terminal_revealer.set_reveal_child(bool.parse(data));
					break;
				
				case ("show-settingsbar"):
					this.settingsbar_revealer.set_reveal_child(bool.parse(data));
					break;
				
				case ("show-sidebar"):
					this.showSideBar(bool.parse(data));
					break;
			}
		}
		
		public void openFileWithDialog()
		{
			Gtk.FileChooserDialog file_chooser = new Gtk.FileChooserDialog("Open File", this, Gtk.FileChooserAction.OPEN, "Cancel", Gtk.ResponseType.CANCEL, "Open", Gtk.ResponseType.ACCEPT);
			
			file_chooser.set_select_multiple(true);
			file_chooser.set_local_only(true);
			
			//Open the dialog
			int response = file_chooser.run();
			
			if (response == Gtk.ResponseType.ACCEPT)
			{
				SList<File> files_chosen = file_chooser.get_files();
				for (int count = 0; count < files_chosen.length(); count ++)
				{
					this.root.consts.output("Opening file " + files_chosen.nth_data(count).get_path());
					
					bool already_open = false;
					for (int count2 = 0; count2 < this.window.source_stack.tabs.length; count2 ++)
					{
						if (this.window.source_stack.tabs[count2].file.equal(files_chosen.nth_data(count)))
						{
							this.root.consts.output("File is already open!");
							already_open = true;
						}
					}
					
					if (already_open == false)
						this.openFile(files_chosen.nth_data(count));
				}
				
				this.root.consts.output("Opened " + files_chosen.length().to_string() + " files");
			}
			
			file_chooser.destroy();
		}
		
		public void openFile(File file)
		{
			TabBox tab = this.source_stack.addTab(file);
			tab.sidebar_tab_row.switchTo();
		}
		
		public void newFile()
		{
			this.source_stack.addTab(null);
		}
		
		public bool pressKey(Gdk.EventKey key)
		{
			//Thanks donadigo. Saved me a few minutes reading documentation :-)
			if((key.state & Gdk.ModifierType.CONTROL_MASK) != 0)
			{                  
				switch (key.keyval)
				{
					case Gdk.Key.@q:
						this.quit();
						break;     
					case Gdk.Key.@n:
						this.newFile();
						break;
					case Gdk.Key.@w:
						this.root.addWindow();
						break;
					case Gdk.Key.@o:
						this.openFileWithDialog();
						break;  
					case Gdk.Key.@s:
						{
							//If shift is held, make it save as
							if (this.source_stack.getCurrentTab() != null)
							{
								this.source_stack.getCurrentTab().save();
							}
						}
						break;
					case Gdk.Key.@k:
						{
							if (this.window.config.getProperty("show-sidebar") == "false")
								this.window.config.setProperty("show-sidebar", "true");
							else
								this.window.config.setProperty("show-sidebar", "false");
						} 
						break;
					case Gdk.Key.@p:
						{
							if (this.window.config.getProperty("show-settingsbar") == "false")
								this.window.config.setProperty("show-settingsbar", "true");
							else
								this.window.config.setProperty("show-settingsbar", "false");
						}
						break;    
				}
			}
			
			return false;
		}
	}
}
