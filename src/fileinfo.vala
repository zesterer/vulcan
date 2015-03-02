namespace Vulcan
{
	public class FileInfoPopover : Gtk.Popover
	{
		public Application root;
		public HeaderBar mother;
		public Window window;
		
		public Gtk.Box info_box;
		public Gtk.Label name_label;
		public Gtk.Label path_label;
		public Gtk.Label filesize_label;
		//public Gtk.Label modified_label;
		
		public FileInfo file_info;
		
		public FileInfoPopover(HeaderBar mother, Gtk.Widget button)
		{
			this.set_relative_to(button);
			
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.info_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 4);
			this.info_box.set_margin_top(4);
			this.info_box.set_margin_bottom(4);
			this.info_box.set_margin_start(8);
			this.info_box.set_margin_end(8);
			this.add(this.info_box);
			
			this.name_label = new Gtk.Label("Name");
			this.info_box.add(this.name_label);
			
			this.path_label = new Gtk.Label("Path");
			this.info_box.add(this.path_label);
			
			this.filesize_label = new Gtk.Label("File Size");
			this.info_box.add(this.filesize_label);
			
			//this.modified_label = new Gtk.Label("Modified");
			//this.info_box.add(this.modified_label);
		}
		
		public void toggleVisible()
		{
			if (this.get_visible())
			{
				this.hide();
			}
			else
			{
				this.show_all();
			}
		}
		
		public void update()
		{
			if (this.window.source_stack.getCurrentTab() != null)
			{
				this.file_info = this.window.source_stack.getCurrentTab().file.query_info("standard::size", 0);
				this.name_label.set_markup(this.window.source_stack.getCurrentTab().filename);
				this.path_label.set_markup(this.window.source_stack.getCurrentTab().file.get_path());
				this.filesize_label.set_markup(this.file_info.get_size().to_string() + " bytes");
				//this.modified_label.set_markup(this.file_info.get_modification_time().to_iso8601());
			}
		}
	}
}
