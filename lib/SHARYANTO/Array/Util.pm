package SHARYANTO::Array::Util;

use 5.010;
use strict;
use warnings;
use Data::Clone;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(match_array_or_regex match_regex_or_array);

our $VERSION = '0.09'; # VERSION

our %SPEC;

$SPEC{match_array_or_regex} = {
    summary => 'Check whether an item matches array of values or regex',
    args_as => 'array',
    args => {
        needle => ["str*" => {
            arg_pos => 0,
        }],
        haystack => ["any*" => {
            of => [["array*"=>{of=>"str*"}], "str*"], # XXX 2nd should be regex*
            arg_pos => 1,
        }],
    },
};
sub match_array_or_regex {
    my ($needle, $haystack) = @_;
    my $ref = ref($haystack);
    if ($ref eq 'Regexp') {
        return $needle =~ $haystack;
    } elsif ($ref eq 'ARRAY') {
        return $needle ~~ @$haystack;
    } else {
        die "Can't match when haystack is a $ref";
    }
}

*match_regex_or_array = \&match_array_or_regex;
$SPEC{match_regex_or_array} = clone $SPEC{match_array_or_regex};
$SPEC{match_regex_or_array}{summary} = 'Alias for match_array_or_regex';

1;
# ABSTRACT: Array-related utilities


__END__
=pod

=head1 NAME

SHARYANTO::Array::Util - Array-related utilities

=head1 VERSION

version 0.09

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

None are exported by default, but they are exportable.

=head2 match_array_or_regex(@args) -> [STATUS_CODE, ERR_MSG, RESULT]


Check whether an item matches array of values or regex.

Returns a 3-element arrayref. STATUS_CODE is 200 on success, or an error code
between 3xx-5xx (just like in HTTP). ERR_MSG is a string containing error
message, RESULT is the actual result.

Arguments (C<*> denotes required arguments):

=over 4

=item * B<needle>* => I<str>

1st argument ($args[0]).

=item * B<haystack>* => I<array|str>

2nd argument ($args[1]).

=back

=head2 match_regex_or_array(@args) -> [STATUS_CODE, ERR_MSG, RESULT]


Alias for match_array_or_regex.

Returns a 3-element arrayref. STATUS_CODE is 200 on success, or an error code
between 3xx-5xx (just like in HTTP). ERR_MSG is a string containing error
message, RESULT is the actual result.

Arguments (C<*> denotes required arguments):

=over 4

=item * B<needle>* => I<str>

1st argument ($args[0]).

=item * B<haystack>* => I<array|str>

2nd argument ($args[1]).

=back

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

