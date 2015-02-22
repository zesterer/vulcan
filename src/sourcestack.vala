namespace Journal
{
	public class SourceStack : Gtk.Stack
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public DynamicList<TabBox> tabs;
		
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
		}
		
		public TabBox addTab(File? file)
		{
			TabBox tab = new TabBox(this, file);
			
			this.tabs.add(tab);
			
			this.add(tab);
			
			this.switchTo(tab);
			
			if (this.tabs.length == 2)
			{
				this.window.showSideBar(true);
			}
			
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
			return (TabBox)this.get_visible_child();
		}
	}
}
