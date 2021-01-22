project('vulcan', 'vala','c')

i18n = import('i18n')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))

gtk_dep = dependency('gtk+-3.0')
gtksourceview_dep = dependency('gtksourceview-3.0')
pango_dep = dependency('pango')
vte_dep = dependency('vte-2.91')

subdir('data')
subdir('src')

#meson.add_install_script('meson/post_install.py')
