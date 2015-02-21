## Please Note: Journalplus Is Currently In Heavy Development And Does Not Function Properly Yet

# JournalNext

A minimalistic text editor designed for both ordinary use and software development.

##What is JournalNext?

JournalNext is the next incarnation of the Journal text editor (version 1.0 seen here: http://www.github.com/evolve-os/journal/). It aims to be fast, and minimalist on first use, and provides the following basic features:

- Multi-file editing
- Monospace text editing
- Saving (including Save As) and loading
- Basic theming

However, it also aims to provide a range of tools helpful to developers including:

- Syntax highlighting
- Syntax highligting scheme theming
- Built-in VTE Terminal
- Line numbering
- Filesystem / source directory view
- (Possible) integration with other build tools

##Why not another mainstream text editor?

JournalNext has both unique features and a unique emphasis on design. Widget elements are smoothly animated, and the interface is designed to be intuitive and self-explanatory. It contains many useful features for more advanced tasks, but emphasises simplicity and versatility.

##How can I build JournalPlus?

At the moment, Journal doesn't have a proper build system and uses a little BASH script for compilation. To compile JournalPlus, execute these commands:

`git clone https://github.com/zesterer/journalnext`

`cd journalnext`

`sh compile.sh`

To run JournalPlus, execute:

`./journal`

##Dependencies

JournalPlus depends on various libraries:

- Gtk 3.14
- VTE 2.90
- Pango
- GtkSourceView
- GLib
- Gio
- Vala

##Credits

JournalPlus is developed by Ryan Sipes & Barry Smith.
All code within this repository is licensed under the GPL 2.0 software license.
