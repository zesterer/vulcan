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
	public class TabBox : Gtk.Box
	{
		public Application root;
		public SourceStack mother;
		public Window window;
		
		public Config config;
		
		public Gtk.ScrolledWindow scrolled_window;
		public Gtk.SourceView source_view;
		public Gtk.SourceBuffer text_buffer;
		public uint text_hash;
		public Gtk.SourceStyleSchemeManager source_style_scheme_manager;
		
		public SideBarTabRow sidebar_tab_row;
		
		public File? file;
		public string filename;
		public string language;
		
		private bool loaded;
		private bool _unsaved;
		public signal void unsavedChanged();
		
		public TabBox(SourceStack mother, File? file)
		{
			this.loaded = false;
			
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this._unsaved = false;
			
			this.file = file;
			
			this.config = new Config(this.root.consts);
			
			this.scrolled_window = new Gtk.ScrolledWindow(null, null);
			this.scrolled_window.set_hexpand(true);
			this.scrolled_window.set_kinetic_scrolling(true);
			this.scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
			this.add(this.scrolled_window);
			
			this.source_view = new Gtk.SourceView();
			this.source_view.editable = true;
			this.source_view.cursor_visible = true;
			this.source_view.set_show_line_numbers(bool.parse(this.window.config.getProperty("line-numbers")));
			this.source_view.set_auto_indent(true);
			this.source_view.set_tab_width(4);
			var fontdec = new Pango.FontDescription();
			fontdec.set_family("Monospace");
			this.source_view.override_font(fontdec);
			
			this.text_buffer = new Gtk.SourceBuffer(null);
			this.text_buffer.changed.connect(this.change_buffer);
			this.source_view.set_buffer(this.text_buffer);
			
			if (this.file != null)
			{
				this.root.consts.output("Loading file " + this.filename);
				this.filename = this.file.get_basename();
				
				string text;
				try
				{
					FileUtils.get_contents(this.file.get_path(), out text);
					this.setSyntaxHighlighting();
					this.root.consts.output("Loaded text from file");
				}
				catch (Error e)
				{
					text = "";
					stderr.printf("Error: %s\n", e.message);
				}
				this.text_buffer.set_text(text);
				this.reHash();
			}
			else
			{
				this.filename = "Untitled";
				this.unsaved = true;
			}
			
			this.source_style_scheme_manager = Gtk.SourceStyleSchemeManager.get_default();
			this.changeSourceScheme(this.window.config.getProperty("scheme"));
			this.text_buffer.set_highlight_syntax(true);
		  
			this.scrolled_window.add(this.source_view);
			
			
			//Create it's sidebar tab row
			this.sidebar_tab_row = new SideBarTabRow(this.window.sidebar.sidebar_list, this);
			
			//Get any updates from the window's config
			this.window.config.dataChanged.connect(this.dataWindowChanged);
			this.unsavedChanged.connect(this.window.filebar.update);
			
			this.show_all();
			
			//Everything's finished and the new tab is loaded!
			this.loaded = true;
			this.update();
		}
		
		public void reHash()
		{
			this.text_hash = text_buffer.text.hash();
			this.unsaved = false;
		}
		
		public void update()
		{	
			if (this.file != null)
			{
				this.filename = this.file.get_basename();
			}
			
			this.sidebar_tab_row.update();
		}
		
		public bool unsaved
		{
			get
			{return this._unsaved;}
			set
			{
				this._unsaved = value;
				this.unsavedChanged();
			}
		}
		
		public void change_buffer()
		{
			if (this.loaded)
			{
				uint new_hash = text_buffer.text.hash();
				this.unsaved = (new_hash != text_hash);
			}
			else
			{
				this.reHash();
			}
		}
		
		public void changeSourceScheme(string scheme)
		{
			this.text_buffer.set_style_scheme(this.source_style_scheme_manager.get_scheme(scheme));
			this.root.consts.output("Changed scheme for tab");
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
		
		public void setSyntaxHighlighting()
		{
			FileInfo? info = null;
			try
			{
				info = this.file.query_info("standard::*", FileQueryInfoFlags.NONE, null);
			}
			catch (Error e)
			{
				warning (e.message);
				return;
			}
		  
			string mime_type = ContentType.get_mime_type (info.get_attribute_as_string (FileAttribute.STANDARD_CONTENT_TYPE));
			
			Gtk.SourceLanguageManager language_manager = new Gtk.SourceLanguageManager();
			language = language_manager.guess_language(this.file.get_path(), mime_type).get_name();
			
			if (language != null)
			{
				this.text_buffer.set_language(language_manager.guess_language(file.get_path(), mime_type));
				this.root.consts.output("Set language to " + language);
			}
			else
			{
				this.root.consts.output("No language set");
			}
		}
		
		public void save(bool saveas = false)
		{
			this.root.consts.output("Now saving...");
			
			if (this.file != null && saveas == false)
			{
				try
				{
					FileUtils.set_contents(file.get_path(), this.text_buffer.text);
					this.reHash();
					this.unsaved = false;
					
					this.root.consts.output("Saved");
				}
				catch (Error error)
				{
					stderr.printf("Error: %s\n", error.message);
				}
			}
			else
			{
				this.root.consts.output("Getting new file choice...");
				
				Gtk.FileChooserDialog file_chooser = new Gtk.FileChooserDialog("Save File", this.window, Gtk.FileChooserAction.SAVE, "Cancel", Gtk.ResponseType.CANCEL, "Save", Gtk.ResponseType.ACCEPT);
			
				file_chooser.set_local_only(true);
				file_chooser.set_do_overwrite_confirmation(true);
				file_chooser.set_create_folders(true);
				
				int response = file_chooser.run();
				
				if (response == Gtk.ResponseType.ACCEPT)
				{
					this.file = File.new_for_path(file_chooser.get_filename());
					this.update();
					this.save();
					return;
				}
				
				file_chooser.destroy();
			}
			
			this.setSyntaxHighlighting();
			this.window.source_stack.switchTo(this.window.source_stack.getCurrentTab());
		}
		
		public void close()
		{
			this.sidebar_tab_row.mother.list_box.remove(this.sidebar_tab_row.parent);
			this.sidebar_tab_row.destroy();
			this.mother.tabs.remove(this);
			this.destroy();
		}
	}
}
