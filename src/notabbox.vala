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
	public class NoTabBox : Gtk.Box
	{
		public Application root;
		public SourceStack mother;
		public Window window;
		
		public Gtk.Label label;
		public Gtk.Box button_box;
		public Gtk.Button new_button;
		public Gtk.Button open_button;
		
		public NoTabBox(SourceStack mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_orientation(Gtk.Orientation.VERTICAL);
			this.set_homogeneous(true);
			
			this.label = new Gtk.Label("");
			this.label.set_justify(Gtk.Justification.CENTER);
			this.label.set_markup("<span font=\"30\">Welcome to " + this.root.consts.name + " " + this.root.consts.version_string + "\n\n</span><span font=\"16\">No files are currently open</span>");
			this.label.set_hexpand(true);
			//this.label.set_vexpand(true);
			this.add(this.label);
			
			this.button_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 16);
			this.button_box.set_homogeneous(true);
			this.add(this.button_box);
			
			this.new_button = new Gtk.Button();
			this.new_button.set_halign(Gtk.Align.CENTER);
			this.new_button.set_valign(Gtk.Align.CENTER);
			this.new_button.set_relief(Gtk.ReliefStyle.NONE);
			this.new_button.override_background_color(Gtk.StateFlags.NORMAL, {0.5, 0.5, 0.5, 0.5});
			this.new_button.width_request = 100;
			this.new_button.height_request = 100;
			this.new_button.set_tooltip_text("Create a new file");
			this.new_button.set_image(new Gtk.Image.from_icon_name("document-new-symbolic", Gtk.IconSize.DIALOG));
			this.new_button.clicked.connect(this.window.filebar.newFileButtonClicked);
			this.button_box.add(this.new_button);
			
			this.open_button = new Gtk.Button();
			this.open_button.set_halign(Gtk.Align.CENTER);
			this.open_button.set_valign(Gtk.Align.CENTER);
			this.open_button.set_relief(Gtk.ReliefStyle.NONE);
			this.open_button.override_background_color(Gtk.StateFlags.NORMAL, {0.5, 0.5, 0.5, 0.5});
			this.open_button.width_request = 100;
			this.open_button.height_request = 100;
			this.open_button.set_tooltip_text("Open an existing file");
			this.open_button.set_image(new Gtk.Image.from_icon_name("document-open-symbolic", Gtk.IconSize.DIALOG));
			this.open_button.clicked.connect(this.window.filebar.openFileButtonClicked);
			this.button_box.add(this.open_button);
		}
	}
}
