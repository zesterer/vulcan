namespace Journal
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
			
			this.hasSwitched.connect(this.window.filebar.update);
			
			this.tabs = new DynamicList<TabBox>();
			
			//The default page
			this.no_tab_box = new NoTabBox(this);
			this.add(this.no_tab_box);
			
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
			this.root.consts.output("Switching to tab with file " + ((TabBox)widget).filename);
			this.set_visible_child(widget);
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
				this.add(this.no_tab_box);
			
			this.hasSwitched();
		}
	}
}
