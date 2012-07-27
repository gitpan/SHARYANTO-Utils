package SHARYANTO::File::Util;

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(file_exists);

our $VERSION = '0.25'; # VERSION

our %SPEC;

sub file_exists {
    my $path = shift;

    !(-l $path) && (-e _) || (-l _);
}

1;
# ABSTRACT: File-related utilities


__END__
=pod

=head1 NAME

SHARYANTO::File::Util - File-related utilities

=head1 VERSION

version 0.25

=head1 SYNOPSIS

 use SHARYANTO::File::Util qw(file_exists);

 print "file exists" if file_exists("/path/to/file/or/dir");

=head1 DESCRIPTION

=head1 FUNCTIONS

None are exported by default, but they are exportable.

=head2 file_exists($path) => BOOL

This routine is just like the B<-e> test, except that it assume symlinks with
non-existent target as existing. If C<sym> is a symlink to a non-existing
target:

 -e "sym"             # false, Perl performs stat() which follows symlink

but:

 -l "sym"             # true, Perl performs lstat()
 -e _                 # false

This function performs the following test:

 !(-l "sym") && (-e _) || (-l _)

=head1 DESCRIPTION


This module has L<Rinci> metadata.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

