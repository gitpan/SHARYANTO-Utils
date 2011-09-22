package SHARYANTO::Array::Util;

use 5.010;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(match_array_or_regex);

our $VERSION = '0.06'; # VERSION

# check whether $needle matches $haystack, haystack maybe an array of values, or
# a regex.
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

1;
# ABSTRACT: Array-related utilities

__END__
=pod

=head1 NAME

SHARYANTO::Array::Util - Array-related utilities

=head1 VERSION

version 0.06

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

