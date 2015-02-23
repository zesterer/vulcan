namespace Journal
{
	public class HeaderBar : Gtk.HeaderBar
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public Gtk.ToggleButton settings_button;
	
		public HeaderBar(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
		
			this.set_title(this.root.consts.name);
			this.set_subtitle(this.root.consts.comment);
			this.set_show_close_button(true);
			
			this.settings_button = new Gtk.ToggleButton();
			this.settings_button.set_image(new Gtk.Image.from_icon_name("open-menu-symbolic", Gtk.IconSize.MENU));
			this.settings_button.clicked.connect(this.settingsBarButtonClicked);
			this.pack_end(this.settings_button);
		}
		
		public void settingsBarButtonClicked()
		{
			this.window.config.setProperty("show-settingsbar", this.settings_button.get_active().to_string());
		}
		
		public void tabSwitched()
		{
			TabBox? tab = this.window.source_stack.getCurrentTab();
			
			if (tab == null)
			{
				this.set_title(this.root.consts.name);
				this.set_subtitle(this.root.consts.comment);
			}
			else
			{
				this.set_title(tab.filename);
				this.set_subtitle(tab.file.get_path());
			}
		}
	}
}
