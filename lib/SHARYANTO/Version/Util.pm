package SHARYANTO::Version::Util;

use 5.010;
use strict;
use version 0.77;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       cmp_version
                       version_eq
                       version_lt version_le version_gt version_ge
               );

our $VERSION = '0.63'; # VERSION

sub cmp_version {
    version->parse($_[0]) <=> version->parse($_[1]);
}

sub version_eq {
    version->parse($_[0]) == version->parse($_[1]);
}

sub version_lt {
    version->parse($_[0]) <  version->parse($_[1]);
}

sub version_le {
    version->parse($_[0]) <= version->parse($_[1]);
}

sub version_gt {
    version->parse($_[0]) >  version->parse($_[1]);
}

sub version_ge {
    version->parse($_[0]) >= version->parse($_[1]);
}

1;
# ABSTRACT: Version utilities

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::Version::Util - Version utilities

=head1 VERSION

version 0.63

=head1 FUNCTIONS

=head2 cmp_version($v1, $v2) => -1|0|1

Equivalent to:

 version->parse($v1) <=> version->parse($v2)

=head2 version_eq($v1, $v2) => BOOL

=head2 version_lt($v1, $v2) => BOOL

=head2 version_le($v1, $v2) => BOOL

=head2 version_gt($v1, $v2) => BOOL

=head2 version_ge($v1, $v2) => BOOL

=head1 SEE ALSO

L<SHARYANTO>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/SHARYANTO-Utils>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-SHARYANTO-Utils>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=SHARYANTO-Utils>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
