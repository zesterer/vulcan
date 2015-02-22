namespace Journal
{
	public class Terminal : Vte.Terminal
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public int pid;
		
		public Terminal(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_hexpand(true);
			this.set_vexpand(false);
			this.set_background_transparent(true);
			
			try
			{
				this.fork_command_full(Vte.PtyFlags.DEFAULT, null, {Vte.get_user_shell()}, null, SpawnFlags.SEARCH_PATH, null, out this.pid);
			}
			catch (Error error)
			{
				this.root.consts.output(error.message);
			}
			
			this.background_transparent = true;
			this.background_opacity = 1.0;
			this.set_color_background_rgba({0.15, 0.15, 0.15, 1.0});
		}
	}
}
