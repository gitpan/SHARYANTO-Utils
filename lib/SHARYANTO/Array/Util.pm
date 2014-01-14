package SHARYANTO::Array::Util;

use 5.010;
use strict;
use warnings;
use experimental 'smartmatch';
use Data::Clone;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(match_array_or_regex match_regex_or_array);

our $VERSION = '0.66'; # VERSION

our %SPEC;

my $_str_or_re = ['any*'=>{of=>['re*','str*']}];

$SPEC{match_array_or_regex} = {
    v => 1.1,
    summary => 'Check whether an item matches (list of) values/regexes',
    description => <<'_',

This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

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
                # turned off temporarily 2012-12-25, Data::Sah is currently broken
                #of => [$_str_or_re, ["array*"=>{of=>$_str_or_re}]],
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

1;
# ABSTRACT: Array-related utilities

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::Array::Util - Array-related utilities

=head1 VERSION

version 0.66

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS


=head2 match_array_or_regex(@args) -> any

Check whether an item matches (list of) values/regexes.

Examples:

 match_array_or_regex(haystack => ["abc", "abd"], needle => "abc"); # -> 1
 match_array_or_regex(haystack => qr/ab./, needle => "abc"); # -> 1
 match_array_or_regex(haystack => [qr/ab./, "abd"], needle => "abc"); # -> 1
This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

Arguments ('*' denotes required arguments):

=over 4

=item * B<haystack>* => I<any>

Check whether an item matches (list of) values/regexes.

This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

=item * B<needle>* => I<str>

Check whether an item matches (list of) values/regexes.

This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

=back

Return value:

=head2 match_regex_or_array(@args) -> any

Alias for match_array_or_regex.

Examples:

 match_regex_or_array(haystack => ["abc", "abd"], needle => "abc"); # -> 1
 match_regex_or_array(haystack => qr/ab./, needle => "abc"); # -> 1
 match_regex_or_array(haystack => [qr/ab./, "abd"], needle => "abc"); # -> 1
This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

Arguments ('*' denotes required arguments):

=over 4

=item * B<haystack>* => I<any>

Alias for match_array_or_regex.

This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

=item * B<needle>* => I<str>

Alias for match_array_or_regex.

This routine can be used to match an item against a regex or a list of
strings/regexes, e.g. when matching against an ACL.

=back

Return value:

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
