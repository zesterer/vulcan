namespace EvolveJournal
{
	public class SourceStack : Gtk.Stack
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public DynamicList<TabBox> tabs;
	
		public SourceStack(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_vexpand(true);
			
			this.tabs = new DynamicList<TabBox>();
			
			this.addTab();
		}
		
		public TabBox addTab()
		{
			TabBox tab = new TabBox(this);
			
			this.tabs.add(tab);
			this.add_named(tab, "test");
			
			return tab;
		}
	}
}
