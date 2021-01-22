# Note: Vulcan is no longer under active development. PRs are still accepted.

# Vulcan

A minimalistic text editor designed for both ordinary use and software development.

[![Click to view YouTube video](https://raw.githubusercontent.com/zesterer/vulcan/master/misc/screenshot.png)](https://www.youtube.com/watch?v=is2f3xVIvFM)

## What is Vulcan?

Vulcan is the next incarnation of the Journal text editor (version 1.0.1 seen here: http://www.github.com/solus-project/journal/). Originally named JournalNext, we've since taken the decision to rename the project 'Vulcan' and make it independent from the Solus project. It aims to be fast, minimalist on first use, and provides the following basic features:

We'd prefer Vulcan's development to be guided by it's users - you. If you have any suggestions for improvements, new features or you've found a bug, we strongly urge you to report it in the issues section.

- Multi-file editing
- Monospace text editing
- Opening (multiple) plaintext files
- Saving (including Save As) plaintext files
- Edit detection using string hashing
- Basic theming / configuration
- Smooth, animated UI
- Keyboard shortcuts for quick access to functionality

However, in addition it also aims to provide a range of tools helpful to developers including:

- Syntax highlighting
- Highlight scheme theming
- Built-in VTE Terminal
- Line numbering

## Why not another mainstream text editor?

Vulcan has both unique features and a unique emphasis on design. Widget elements are smoothly animated, and the interface is designed to be intuitive and self-explanatory. It contains many useful features for more advanced tasks, but emphasises simplicity and versatility. Vulcan's development is largely user-orientated.

## How can I build Vulcan?

At the moment, Vulcan doesn't have a proper build system and uses a little BASH script for compilation. To compile Vulcan, execute these commands:

```
git clone https://github.com/zesterer/Vulcan

meson build
ninja -C build
ninja -C build install
```

## Dependencies

Vulcan depends on various libraries:

- Gtk 3.14
- VTE 2.91
- Pango
- GtkSourceView
- GLib
- Gio
- Vala

## Planned Features

Please note that this list is subject to change.

- Filesystem / source directory view
- (Possible) integration with other build tools
- Syntax completion
- Pastebin / Hastebin integration
- More sharing tools
- Keyboard shortcuts
- Restore files from previous session
- Keyboard shortcuts
- Drop-down language chooser

## User-Suggested (Potential) Wishlist

- Return to popover settings?
- Optional horizontal tab bar
- Overview pane (a la sublime)
- Option to hide all buttons and rely on shortcuts
- Gedit-style open files system

Got any more ideas? Suggest them in the issues section!

## Credits

Vulcan is developed by Ryan Sipes & Barry Smith.
All code within this repository is licensed under the GPL 2.0 software license unless otherwise specified.
