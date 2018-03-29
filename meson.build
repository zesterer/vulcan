project('vulcan', ['vala', 'c'])

deps = [
	dependency('glib-2.0'),
	dependency('gobject-2.0'),
	dependency('gtk+-3.0'),
	dependency('gtksourceview-3.0'),
	dependency('vte-2.91'),
	dependency('pango'),
]

add_project_arguments([
	'--define', 'HAVE_VTE291'
], language: 'vala')

subdir('src')

executable(
	'vulcan',
	src,
	dependencies: deps,
)
