namespace EvolveJournal
{
	public class SideBarList : Gtk.Box
	{
		public Application root;
		public SideBar mother;
		public Window window;
		
		public Gtk.ScrolledWindow scrolled_window;
		public Gtk.ListBox list_box;
		
		public SideBarList(SideBar mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_vexpand(true);
			
			this.scrolled_window = new Gtk.ScrolledWindow(null, null);
			this.scrolled_window.width_request = 180;
			this.add(this.scrolled_window);
			
			this.list_box = new Gtk.ListBox();
			this.list_box.set_selection_mode(Gtk.SelectionMode.SINGLE);
			this.scrolled_window.add(this.list_box);
		}
	}
	
	public class SideBarTabRow : Gtk.Box
	{
		public Application root;
		public SideBarList mother;
		public Window window;
		public unowned TabBox owner;
		
		public Gtk.Image icon;
		public Gtk.Label label;
		public Gtk.Button close_button;
		
		public SideBarTabRow(SideBarList mother, TabBox owner)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			this.owner = owner;
			
			this.set_orientation(Gtk.Orientation.HORIZONTAL);
			this.set_margin_start(8);
			this.set_margin_end(8);
			this.set_spacing(8);
			this.set_tooltip_text(this.owner.filename);
			
			this.icon = new Gtk.Image();
			this.icon.set_from_icon_name("text-x-generic-symbolic", Gtk.IconSize.MENU);
			this.add(this.icon);
			
			this.label = new Gtk.Label(this.owner.filename);
			this.label.set_ellipsize(Pango.EllipsizeMode.END);
			this.add(this.label);
			
			this.close_button = new Gtk.Button();
			this.close_button.set_halign(Gtk.Align.END);
			this.close_button.set_relief(Gtk.ReliefStyle.NONE);
			this.close_button.set_image(new Gtk.Image.from_icon_name("window-close-symbolic", Gtk.IconSize.BUTTON));
			this.close_button.clicked.connect(this.owner.close);
			this.pack_end(this.close_button);
			
			this.mother.list_box.add(this);
			this.show_all();
			
			this.mother.list_box.row_selected.connect(this.clickSelected);
		}
		
		public void switchTo()
		{
			this.root.consts.output("Switching to tab with file " + this.owner.filename);
			this.window.source_stack.switchTo(this.owner);
		}
		
		public void clickSelected(Gtk.ListBoxRow? row)
		{
			if (row.get_child() == this)
			{
				this.switchTo();
			}
		}
	}
}
