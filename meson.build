project(
	'com.github.zesterer.vulcan',
	['vala', 'c'],
	version: '0.1.0',
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language: 'c')

deps = [
	dependency('glib-2.0'),
	dependency('gobject-2.0'),
	dependency('gtk+-3.0'),
	dependency('gtksourceview-3.0'),
	dependency('vte-2.91'),
]

subdir('src')

executable(
	meson.project_name(),
	src,
	dependencies: deps,
	install: true,
)

subdir('data')
