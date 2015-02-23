#!/usr/bin/sh

NAME=vulcan

valac -o $NAME -X -lm \
--pkg gtk+-3.0 \
--pkg gtksourceview-3.0 \
--pkg pango \
--pkg vte-2.90 \
src/main.vala \
src/window.vala \
src/headerbar.vala \
src/consts.vala \
src/sourcestack.vala \
src/tabbox.vala \
src/dynamiclist.vala \
src/sidebar.vala \
src/filebar.vala \
src/settingsbar.vala \
src/terminal.vala \
src/sidebarlist.vala \
src/config.vala \
src/notabbox.vala \
#-X -fsanitize=address \
#Uncomment the line below to allow debugging

LINES_VALA=`( find src -name '*.vala' -print0 | xargs -0 cat ) | wc -l`

echo "There are $LINES_VALA lines of Vala code in the src directory."
