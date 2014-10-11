package SHARYANTO::List::Util;

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       uniq_adj
                       uniq_adj_ci
                       uniq_ci
                       find_missing_nums_in_seq
                       find_missing_strs_in_seq
               );

our $VERSION = '0.76'; # VERSION
our $DATE = '2014-10-11'; # DATE

sub uniq_adj {
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

sub uniq_adj_ci {
    my @res;

    return () unless @_;
    my $last = shift;
    push @res, $last;
    for (@_) {
        next if !defined($_) && !defined($last);
        # XXX $_ becomes stringified
        next if defined($_) && defined($last) && lc($_) eq lc($last);
        push @res, $_;
        $last = $_;
    }
    @res;
}

sub uniq_ci {
    my @res;

    my %mem;
    for (@_) {
        push @res, $_ unless $mem{lc $_}++;
    }
    @res;
}

sub find_missing_nums_in_seq {
    require List::Util;

    my @res;
    my $min = List::Util::min(@_);
    my $max = List::Util::max(@_);

    my %h = map { $_=>1 } @_;
    for ($min..$max) {
        push @res, $_ unless $h{$_};
    }
    wantarray ? @res : \@res;
}

sub find_missing_strs_in_seq {
    require List::Util;

    my @res;
    my $min = List::Util::minstr(@_);
    my $max = List::Util::maxstr(@_);

    my %h = map { $_=>1 } @_;
    for ($min..$max) {
        push @res, $_ unless $h{$_};
    }
    wantarray ? @res : \@res;
}

1;
# ABSTRACT: List utilities

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::List::Util - List utilities

=head1 VERSION

This document describes version 0.76 of SHARYANTO::List::Util (from Perl distribution SHARYANTO-Utils), released on 2014-10-11.

=head1 FUNCTIONS

Not exported by default but exportable.

=head2 uniq_adj(@list) => LIST

Remove I<adjacent> duplicates from list, i.e. behave more like Unix utility's
B<uniq> instead of L<List::MoreUtils>'s C<uniq> function, e.g.

 my @res = uniq(1, 4, 4, 3, 1, 1, 2); # 1, 4, 3, 1, 2

=head2 uniq_adj_ci(@list) => LIST

Like C<uniq_adj> except case-insensitive.

=head2 uniq_ci(@list) => LIST

Like C<List::MoreUtils>' C<uniq> except case-insensitive.

=head2 find_missing_nums_in_seq(LIST) => LIST

Given a list of integers, return number(s) missing in the sequence, e.g.:

 find_missing_nums_in_seq(1, 2, 3, 4, 7, 8); # (5, 6)

=head2 find_missing_strs_in_seq(LIST) => LIST

Like C<find_missing_nums_in_seq>, but for strings/letters "a".."z".

 find_missing_strs_in_seq("a", "e", "b"); # ("c", "d")
 find_missing_strs_in_seq("aa".."zu", "zz"); # ("zv", "zw", "zx", "zy")

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

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
