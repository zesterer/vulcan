namespace EvolveJournal
{
	public class TabBox : Gtk.Box
	{
		public Application root;
		public SourceStack mother;
		public Window window;
		
		public Config config;
		
		public Gtk.ScrolledWindow scrolled_window;
		public Gtk.SourceView source_view;
		public Gtk.SourceBuffer text_buffer;
		public Gtk.SourceStyleSchemeManager source_style_scheme_manager;
		
		public bool unsaved;
		
		public TabBox(SourceStack mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.config = new Config(this.root.consts);
			
			this.scrolled_window = new Gtk.ScrolledWindow(null, null);
			this.scrolled_window.set_hexpand(true);
			this.scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
			this.add(this.scrolled_window);
			
			this.source_view = new Gtk.SourceView();
			this.source_view.editable = true;
			this.source_view.cursor_visible = true;
			this.source_view.set_show_line_numbers(bool.parse(this.window.config.getProperty("line-numbers")));
			this.source_view.set_auto_indent(true);
			var fontdec = new Pango.FontDescription();
			fontdec.set_family("Monospace");
			this.source_view.modify_font(fontdec);
			
			this.text_buffer = new Gtk.SourceBuffer(null);
			this.text_buffer.changed.connect(this.change_buffer);
			this.source_view.set_buffer(this.text_buffer);
			
			this.source_style_scheme_manager = Gtk.SourceStyleSchemeManager.get_default();
			this.changeSourceScheme(this.window.config.getProperty("scheme"));
			this.text_buffer.set_highlight_syntax(true);
		  
			this.scrolled_window.add(this.source_view);
			
			this.unsaved = false;
			
			//Get any updates from the window's config
			this.window.config.dataChanged.connect(this.dataWindowChanged);
		}
		
		public void change_buffer()
		{
			this.unsaved = true;
			this.mother.mother.filebar.save_button.override_background_color(Gtk.StateFlags.NORMAL, {1.0, 0.1, 0.0, 0.4});
		}
		
		public void changeSourceScheme(string scheme)
		{
			this.text_buffer.set_style_scheme(this.source_style_scheme_manager.get_scheme(scheme));
		}
		
		public void dataWindowChanged(string name, string data)
		{
			switch (name)
			{
				case ("scheme"):
					this.changeSourceScheme(data);
					break;
				
				case ("line-numbers"):
					this.source_view.set_show_line_numbers(bool.parse(data));
					break;
			}
		}
	}
}
