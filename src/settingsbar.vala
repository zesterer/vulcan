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
	public class SettingsBar : Gtk.Box
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public Gtk.ScrolledWindow scrolled_window;
		public Gtk.ListBox list_box;
		
		public Gtk.Label label;
		public DarkThemeSwitchRow dark_switch_row;
		public LineNumbersSwitchRow line_switch_row;
		public TextWrapSwitchRow text_wrap_row;
		public SourceSchemeRow source_scheme_row;
		public ShowTerminalSwitchRow terminal_switch_row;
		
		public Gtk.Box bottom_box;
		public Gtk.Button about_button;
		
		public SettingsBar(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_orientation(Gtk.Orientation.VERTICAL);
			this.set_vexpand(true);
			
			this.scrolled_window = new Gtk.ScrolledWindow(null, null);
			this.scrolled_window.set_vexpand(true);
			this.scrolled_window.width_request = 240;
			this.scrolled_window.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC);
			//this.scrolled_window.set_shadow_type(Gtk.ShadowType.ETCHED_OUT);
			this.add(this.scrolled_window);
			
			this.list_box = new Gtk.ListBox();
			this.list_box.set_selection_mode(Gtk.SelectionMode.NONE);
			this.scrolled_window.add(this.list_box);
			
			this.label = new Gtk.Label("");
			this.label.set_justify(Gtk.Justification.CENTER);
			this.label.set_markup("<span font=\"20\">Settings</span>");
			this.label.set_hexpand(true);
			this.label.set_margin_top(16);
			this.label.set_margin_bottom(16);
			this.list_box.add(this.label);
			
			this.dark_switch_row = new DarkThemeSwitchRow(this);
			this.list_box.add(this.dark_switch_row);
			
			this.line_switch_row = new LineNumbersSwitchRow(this);
			this.list_box.add(this.line_switch_row);
			
			this.text_wrap_row = new TextWrapSwitchRow(this);
			this.list_box.add(this.text_wrap_row);
			
			this.source_scheme_row = new SourceSchemeRow(this);
			this.list_box.add(this.source_scheme_row);
			
			this.terminal_switch_row = new ShowTerminalSwitchRow(this);
			this.list_box.add(this.terminal_switch_row);
			
			this.bottom_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 4);
			this.add(this.bottom_box);
			
			this.about_button = new Gtk.Button();
			this.about_button.set_image(new Gtk.Image.from_icon_name("dialog-information-symbolic", Gtk.IconSize.MENU));
			this.about_button.set_tooltip_text("About");
			this.about_button.clicked.connect(this.showAboutDialog);
			this.bottom_box.pack_start(this.about_button);
		}
		
		public void showAboutDialog()
		{
			Gtk.show_about_dialog(this.window,
			"program-name", this.root.consts.name,
			"copyright", this.root.consts.copyright,
			"license-type", Gtk.License.GPL_2_0,
			"comments", this.root.consts.comment,
			"version", this.root.consts.version_string,
			"logo-icon-name", this.root.consts.smallname,
			"authors", this.root.consts.authors);
		}
	}
	
	public class SettingsRowGeneric : Gtk.Box
	{
		public Application root;
		public SettingsBar mother;
		public Window window;
		
		public SettingsRowGeneric(SettingsBar mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.orientation = Gtk.Orientation.HORIZONTAL;
			this.set_margin_start(16);
			this.set_margin_end(16);
			this.set_margin_top(4);
			this.set_margin_bottom(4);
			this.set_spacing(8);
		}
	}
	
	public class DarkThemeSwitchRow : SettingsRowGeneric
	{
		public Gtk.Label label;
		public Gtk.Switch switcher;
		
		public DarkThemeSwitchRow(SettingsBar mother)
		{
			base(mother);
			
			this.set_tooltip_text("Switch between the dark and light theme variants");
			
			this.label = new Gtk.Label("Dark Theme");
			this.add(this.label);
			
			this.switcher = new Gtk.Switch();
			this.switcher.set_halign(Gtk.Align.END);
			this.switcher.set_state(bool.parse(this.root.config.getProperty("dark-theme")));
			this.switcher.state_set.connect(this.setState);
			this.pack_end(this.switcher);
		}
		
		public bool setState(bool state)
		{
			this.root.config.setProperty("dark-theme", state.to_string());
			return true;
		}
	}
	
	public class LineNumbersSwitchRow : SettingsRowGeneric
	{
		public Gtk.Label label;
		public Gtk.Switch switcher;
		
		public LineNumbersSwitchRow(SettingsBar mother)
		{
			base(mother);
			
			this.set_tooltip_text("Toggle displaying line numbers");
			
			this.label = new Gtk.Label("Line Numbers");
			this.add(this.label);
			
			this.switcher = new Gtk.Switch();
			this.switcher.set_halign(Gtk.Align.END);
			this.switcher.set_state(bool.parse(this.window.config.getProperty("line-numbers")));
			this.switcher.state_set.connect(this.setState);
			this.pack_end(this.switcher);
		}
		
		public bool setState(bool state)
		{
			this.window.config.setProperty("line-numbers", state.to_string());
			return true;
		}
	}
	
	public class SourceSchemeRow : SettingsRowGeneric
	{
		public Gtk.Label label;
		public Gtk.ComboBoxText combo_box;
		
		public SourceSchemeRow(SettingsBar mother)
		{
			base(mother);
			
			this.set_tooltip_text("Choose which scheme text in the editor should be themed with");
			
			this.label = new Gtk.Label("Text Scheme");
			this.add(this.label);
			
			this.combo_box = new Gtk.ComboBoxText();
			this.combo_box.set_halign(Gtk.Align.END);
			
			//Find all the currently available schemes
			Gtk.SourceStyleSchemeManager scheme_manager = Gtk.SourceStyleSchemeManager.get_default();
			string[] schemes = scheme_manager.get_scheme_ids();
			for (int count = 0; count < schemes.length; count ++)
			{
				this.combo_box.append_text(schemes[count]);
				if (this.window.config.getProperty("scheme") == schemes[count])
					this.combo_box.set_active(count);
			}
			
			this.combo_box.changed.connect(this.changeScheme);
			this.pack_end(this.combo_box);
		}
		
		public void changeScheme()
		{
			this.window.config.setProperty("scheme", this.combo_box.get_active_text());
		}
	}
	
	public class ShowTerminalSwitchRow : SettingsRowGeneric
	{
		public Gtk.Label label;
		public Gtk.Switch switcher;
		
		public ShowTerminalSwitchRow(SettingsBar mother)
		{
			base(mother);
			
			this.set_tooltip_text("Toggle VTE Terminal visibility");
			
			this.label = new Gtk.Label("Show Terminal");
			this.add(this.label);
			
			this.switcher = new Gtk.Switch();
			this.switcher.set_halign(Gtk.Align.END);
			this.switcher.set_state(bool.parse(this.window.config.getProperty("show-terminal")));
			this.switcher.state_set.connect(this.setState);
			this.pack_end(this.switcher);
		}
		
		public bool setState(bool state)
		{
			this.window.config.setProperty("show-terminal", state.to_string());
			return true;
		}
	}
	
	public class TextWrapSwitchRow : SettingsRowGeneric
	{
		public Gtk.Label label;
		public Gtk.Switch switcher;
		
		public TextWrapSwitchRow(SettingsBar mother)
		{
			base(mother);
			
			this.set_tooltip_text("Toggle text wrapping over lines");
			
			this.label = new Gtk.Label("Text Wrapping");
			this.add(this.label);
			
			this.switcher = new Gtk.Switch();
			this.switcher.set_halign(Gtk.Align.END);
			this.switcher.set_state(bool.parse(this.window.config.getProperty("text-wrap")));
			this.switcher.state_set.connect(this.setState);
			this.pack_end(this.switcher);
		}
		
		public bool setState(bool state)
		{
			this.window.config.setProperty("text-wrap", state.to_string());
			return true;
		}
	}
}
