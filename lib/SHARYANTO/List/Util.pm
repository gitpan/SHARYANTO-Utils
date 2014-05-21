package SHARYANTO::List::Util;

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       uniq
               );

our $VERSION = '0.74'; # VERSION
our $DATE = '2014-05-21'; # DATE

sub uniq {
    my @res;

    return () unless @_;
    my $last = shift;
    push @res, $last;
    for (@_) {
        next if !defined($_) && !defined($last);
        # XXX $_ becomes stringified
        next if defined($_) && defined($last) && $_ eq $last;
        push @res, $_;
        $last = $_;
    }
    @res;
}

1;
# ABSTRACT: List utilities

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::List::Util - List utilities

=head1 VERSION

This document describes version 0.74 of SHARYANTO::List::Util (from Perl distribution SHARYANTO-Utils), released on 2014-05-21.

=head1 SYNOPSIS

 use SHARYANTO::List::Util qw(uniq);

 my @res = uniq(1, 4, 4, 3, 1, 1, 2); # 1, 4, 3, 1, 2

=head1 DESCRIPTION

=head1 FUNCTIONS

=head2 uniq(@list) => LIST

Remove I<adjacent> duplicates from list, i.e. behave more like Unix utility's
B<uniq> instead of L<List::MoreUtils>'s C<uniq> function.

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

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
