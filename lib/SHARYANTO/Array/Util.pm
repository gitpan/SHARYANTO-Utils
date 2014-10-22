package SHARYANTO::Array::Util;

use 5.010;
use strict;
use warnings;
use experimental 'smartmatch';
use Data::Clone;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       match_array_or_regex
                       match_regex_or_array
                       split_array
               );

our $VERSION = '0.72'; # VERSION

our %SPEC;

my $_str_or_re = ['any*'=>{of=>['re*','str*']}];

$SPEC{match_array_or_regex} = {
    v => 1.1,
    summary => 'Check whether an item matches (list of) values/regexes',
    description => <<'_',

This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

Since the smartmatch (`~~`) operator can already match against a list of strings
or regexes, this function is currently basically equivalent to:

    if (reg($haystack) eq 'ARRAY') {
        return $needle ~~ @$haystack;
    } else {
        return $needle =~ /$haystack/;
    }

_
    examples => [
        {args=>{needle=>"abc", haystack=>["abc", "abd"]}, result=>1},
        {args=>{needle=>"abc", haystack=>qr/ab./}, result=>1},
        {args=>{needle=>"abc", haystack=>[qr/ab./, "abd"]}, result=>1},
    ],
    args_as => 'array',
    args => {
        needle => {
            schema => ["str*"],
            pos => 0,
            req => 1,
        },
        haystack => {
            # XXX checking this schema might actually take longer than matching
            # the needle! so when arg validation is implemented, provide a way
            # to skip validating this schema

            schema => ["any*" => {
                of => [$_str_or_re, ["array*"=>{of=>$_str_or_re}]],
            }],
            pos => 1,
            req => 1,
        },
    },
    result_naked => 1,
};
sub match_array_or_regex {
    my ($needle, $haystack) = @_;
    my $ref = ref($haystack);
    if ($ref eq 'ARRAY') {
        return $needle ~~ @$haystack;
    } elsif (!$ref) {
        return $needle =~ /$haystack/;
    } elsif ($ref eq 'Regexp') {
        return $needle =~ $haystack;
    } else {
        die "Invalid haystack, must be regex or array of strings/regexes";
    }
}

*match_regex_or_array = \&match_array_or_regex;
$SPEC{match_regex_or_array} = clone $SPEC{match_array_or_regex};
$SPEC{match_regex_or_array}{summary} = 'Alias for match_array_or_regex';

sub split_array {
    no strict 'refs';

    my ($pat, $ary, $limit) = @_;

    die "BUG: Second argument must be an array" unless ref($ary) eq 'ARRAY';
    $pat = qr/\A\Q$pat\E\z/ unless ref($pat) eq 'Regexp';

    my @res;
    my $num_elems = 0;
    my $i = 0;
  ELEM:
    while ($i < @$ary) {
        push @res, [];
      COLLECT:
        while (1) {
            if ($ary->[$i] =~ $pat) {
                push @res, [map { ${"$_"} } 1..@+-1] if @+ > 1;
                last COLLECT;
            }
            push @{ $res[-1] }, $ary->[$i];
            last ELEM unless ++$i < @$ary;
        }
        $num_elems++;
      LIMIT:
        if (defined($limit) && $limit > 0 && $num_elems >= $limit) {
            push @{ $res[-1] }, $ary->[$_] for $i..(@$ary-1);
            last ELEM;
        }
        $i++;
    }

    return @res;
}

1;
# ABSTRACT: Array-related utilities

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::Array::Util - Array-related utilities

=head1 VERSION

This document describes version 0.72 of SHARYANTO::Array::Util (from Perl distribution SHARYANTO-Utils), released on 2014-05-08.

=head1 SYNOPSIS

 use SHARYANTO::Array::Util qw(match_array_or_regex split_array);

 match_array_or_regex('bar',  ['foo', 'bar', qr/[xyz]/]); # true, matches string
 match_array_or_regex('baz',  ['foo', 'bar', qr/[xyz]/]); # true, matches regex
 match_array_or_regex('oops', ['foo', 'bar', qr/[xyz]/]); # false

 my @res = split_array('--', [qw/--opt1 --opt2 -- foo bar -- --val/]);
 # -> ([qw/--opt1 --opt2/],  [qw/foo bar/],  [qw/--val/])

 my @res = split_array(qr/--/, [qw/--opt1 --opt2 -- foo bar -- --val/], 2);
 # -> ([qw/--opt1 --opt2/],  [qw/foo bar -- --val/])

 my @res = split_array(qr/(--)/, [qw/--opt1 --opt2 -- foo bar -- --val/], 2);
 # -> ([qw/--opt1 --opt2/],  [qw/--/],  [qw/foo bar -- --val/])

 my @res = split_array(qr/(-)(-)/, [qw/--opt1 --opt2 -- foo bar -- --val/], 2);
 # -> ([qw/--opt1 --opt2/],  [qw/- -/],  [qw/foo bar -- --val/])

=head1 DESCRIPTION

=head1 FUNCTIONS

=head2 split_array($str_or_re, \@array[, $limit]) => LIST

Like the C<split()> builtin Perl function, but applies on an array instead of a
scalar. It loosely follows the C<split()> semantic, with some exceptions.


=head2 match_array_or_regex(@args) -> any

Check whether an item matches (list of) values/regexes.

Examples:

 match_array_or_regex( haystack => ["abc", "abd"], needle => "abc"); # -> 1
 match_array_or_regex( haystack => qr/ab./, needle => "abc"); # -> 1
 match_array_or_regex( haystack => [qr/ab./, "abd"], needle => "abc"); # -> 1
This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

Since the smartmatch (C<~~>) operator can already match against a list of strings
or regexes, this function is currently basically equivalent to:

    if (reg($haystack) eq 'ARRAY') {
        return $needle ~~ @$haystack;
    } else {
        return $needle =~ /$haystack/;
    }

Arguments ('*' denotes required arguments):

=over 4

=item * B<haystack>* => I<any|array>

=item * B<needle>* => I<str>

=back

Return value:


=head2 match_regex_or_array(@args) -> any

Alias for match_array_or_regex.

Examples:

 match_regex_or_array( haystack => ["abc", "abd"], needle => "abc"); # -> 1
 match_regex_or_array( haystack => qr/ab./, needle => "abc"); # -> 1
 match_regex_or_array( haystack => [qr/ab./, "abd"], needle => "abc"); # -> 1
This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

Since the smartmatch (C<~~>) operator can already match against a list of strings
or regexes, this function is currently basically equivalent to:

    if (reg($haystack) eq 'ARRAY') {
        return $needle ~~ @$haystack;
    } else {
        return $needle =~ /$haystack/;
    }

Arguments ('*' denotes required arguments):

=over 4

=item * B<haystack>* => I<any|array>

=item * B<needle>* => I<str>

=back

Return value:

=head1 TODO

=over

=item * [REJECT] split_array: By default operate on C<@_>?

Like C<split>'s behavior of by default operating on C<$_>.

=back

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
