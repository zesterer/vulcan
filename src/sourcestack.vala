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
	public class SourceStack : Gtk.Stack
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public DynamicList<TabBox> tabs;
		
		public NoTabBox no_tab_box;
		
		public signal void hasSwitched();
	
		public SourceStack(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_vexpand(true);
			this.set_hexpand(true);
			this.set_transition_type(Gtk.StackTransitionType.SLIDE_UP_DOWN);
			this.set_transition_duration(500);
			
			this.hasSwitched.connect(this.window.filebar.update);
			
			this.tabs = new DynamicList<TabBox>();
			
			//The default page
			this.no_tab_box = new NoTabBox(this);
			this.add(this.no_tab_box);
			this.switchTo(this.no_tab_box);
			
			this.remove.connect(this.checkRemove);
		}
		
		public TabBox addTab(File? file)
		{
			TabBox tab = new TabBox(this, file);
			
			this.tabs.add(tab);
			
			this.add(tab);
			
			this.switchTo(tab);
			
			if (this.tabs.length == 1)
				this.remove(this.no_tab_box);
			
			if (this.tabs.length == 1)
				this.window.config.setProperty("show-sidebar", "true");
			
			return tab;
		}
		
		public void switchTo(Gtk.Widget widget)
		{
			if (widget != this.no_tab_box)
				this.root.consts.output("Switching to tab with file " + ((TabBox)widget).filename);
			this.set_visible_child(widget);
			if (widget != this.no_tab_box)
				this.window.sidebar.sidebar_list.list_box.select_row((Gtk.ListBoxRow)((TabBox)widget).sidebar_tab_row.parent);
			this.hasSwitched();
		}
		
		public unowned TabBox? getCurrentTab()
		{
			if (this.get_visible_child() == this.no_tab_box)
				return null;
			
			return (TabBox)this.get_visible_child();
		}
		
		public void checkRemove(Gtk.Widget widget)
		{
			if (this.tabs.length == 0)
				this.window.config.setProperty("show-sidebar", "false");
			
			this.root.consts.output("Removed tab");
			if (this.tabs.length == 0)
			{
				this.add(this.no_tab_box);
				this.switchTo(this.no_tab_box);
			}
			
			this.hasSwitched();
		}
	}
}
