##Please Note That Vulcan Is Currently In Heavy Development And Does Not Function Properly Yet

#Vulcan

A minimalistic text editor designed for both ordinary use and software development.

[![Click to view YouTube video](https://raw.githubusercontent.com/zesterer/vulcan/master/misc/screenshot.png)](https://www.youtube.com/watch?v=is2f3xVIvFM)

##What is Vulcan?

Vulcan is the next incarnation of the Vulcan text editor (version 1.0 seen here: http://www.github.com/evolve-os/vulcan/). It aims to be fast, minimalist on first use, and provides the following basic features:

- Multi-file editing
- Monospace text editing
- Saving (including Save As) and loading
- Edit detection using string hashing
- Basic theming

However, in addition it also aims to provide a range of tools helpful to developers including:

- Syntax highlighting
- Highlight scheme theming
- Built-in VTE Terminal
- Line numbering

##Why not another mainstream text editor?

Vulcan has both unique features and a unique emphasis on design. Widget elements are smoothly animated, and the interface is designed to be intuitive and self-explanatory. It contains many useful features for more advanced tasks, but emphasises simplicity and versatility.

##How can I build Vulcan?

At the moment, Vulcan doesn't have a proper build system and uses a little BASH script for compilation. To compile Vulcan, execute these commands:

`git clone https://github.com/zesterer/Vulcan`

`cd Vulcan`

`sh compile.sh`

To run Vulcan, execute:

`./Vulcan`

##Dependencies

Vulcan depends on various libraries:

- Gtk 3.14
- VTE 2.90
- Pango
- GtkSourceView
- GLib
- Gio
- Vala

##Planned Features

Please note that this list is subject to change.

- Filesystem / source directory view
- (Possible) integration with other build tools
- Syntax completion
- Pastebin / Hastebin integration
- More sharing tools

##Credits

Vulcan is developed by Ryan Sipes & Barry Smith.
All code within this repository is licensed under the GPL 2.0 software license unless otherwise specified.
