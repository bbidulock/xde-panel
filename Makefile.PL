use ExtUtils::MakeMaker;
my $VERSION = '0.01';
if (-d ".git") {
	$VERSION = `git describe --tags`;
	$VERSION =~ s/[-_]/./g;
	$VERSION =~ s/\.g[0-9a-f]{7,}$//;
}
WriteMakefile(
	NAME => 'XDE::Panel',
	VERSION => $VERSION,
	LICENSE => 'perl',
	ABSTRACT => 'EWMH and XDG compliant panel for XDE',
	AUTHOR => 'Brian Bidulock <bidulock@openss7.org>',
	EXE_FILES => [qw(
		xde-panel
	)],
	PREREQ_PM => {
		'Carp' => 0,			# perl
		'Encode' => 0,			# perl
		'Fcntl' => 0,			# perl
		'File::Path' => 0,		# perl
		'File::stat' => 0,		# perl
		'File::Which' => 0,		# perl-file-which
		'Getopt::Long' => 0,		# perl
		'Glib' => 0,			# glib-perl
		'Gnome2::VFS' => 0,		# gnome-vfs-perl
		'Gtk2' => 0,			# gtk2-perl
		'I18N::Langinfo' => 0,		# perl
		'IO::Select' => 0,		# perl
		'Linux::Inotify2' => 0,		# perl-linux-inotify2
		'Net::DBus' => 0,		# perl-dbus-git
		'Net::DBus::GLib' => 0,		# perl-net-dbus-glib
		'POSIX' => 0,			# perl
		'Time::gmtime' => 0,		# perl
		'Time::HiRes' => 0,		# perl
		'URI::file' => 0,		# perl-uri
		'X11::Keysyms' => 0,		# perl-x11-protocol
		'X11::Protocol' => 0,		# perl-x11-protocol
						# perl-x11-protocol-other
		'X11::Protocol::Enhanced' => 0,	# perl-x11-protocol-more
		'XML::SAX::ParserFactory' => 0,	# perl-xml-sax
	},
	# basically strip the pod out of the .pm file and squeeze blank lines
	PM_FILTER => qq{(sed '/^=[^c]/,/^=cut/d'|cat -s)},
);

sub MY::postamble {
	return <<MAKE_FRAG;

.PHONY: install_xdg
install:: install_xdg

install_xdg:
	install -dm0755 "\$(DESTDIR)/etc"
	cp -rv xdg "\$(DESTDIR)/etc"

MAKE_FRAG
}
