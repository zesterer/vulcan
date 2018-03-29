// file : headerbar.vala
//
// Copyright (C) 2018  Joshua Barretto <joshua.s.barretto@gmail.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

namespace vulcan {
	public class HeaderBar : Gtk.HeaderBar {
		Gtk.Button nwin_button;
		public HeaderBar() {
			this.set_show_close_button(true);
			this.title = "Vulcan";
			this.subtitle = "unnamed.txt";

			this.nwin_button = new Gtk.Button();
			this.nwin_button.set_image(new Gtk.Image.from_icon_name("text-editor-symbolic", Gtk.IconSize.MENU));
			this.nwin_button.set_tooltip_text("Open a new window");
			this.pack_start(this.nwin_button);
		}
	}
}
