namespace EvolveJournal
{
	public class SideBar : Gtk.Stack
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public SideBarList sidebar_list;
		
		public SideBar(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.width_request = 150;
			
			this.sidebar_list = new SideBarList(this);
			this.add(this.sidebar_list);
		}
	}
}
