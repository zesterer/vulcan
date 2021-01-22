sources = [
    'main.vala',
    'window.vala',
    'headerbar.vala',
    'consts.vala',
    'sourcestack.vala',
    'tabbox.vala',
    'dynamiclist.vala',
    'sidebar.vala',
    'filebar.vala',
    'settingsbar.vala',
    'terminal.vala',
    'sidebarlist.vala',
    'config.vala',
    'notabbox.vala',
    'fileinfo.vala'
]

executable(
    meson.project_name(),
    sources,
    dependencies: [gtksourceview_dep,gtk_dep,pango_dep,vte_dep],
    install: true,
    install_dir: join_paths(prefix, 'bin')
)
