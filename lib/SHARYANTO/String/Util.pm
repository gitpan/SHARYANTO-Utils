package SHARYANTO::String::Util;

use 5.010;
use strict;
use warnings;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(trim_blank_lines);

sub trim_blank_lines {
    local $_ = shift;
    return $_ unless defined;
    s/\A(?:\n\s*)+//;
    s/(?:\n\s*){2,}\z/\n/;
    $_;
}

1;
# ABSTRACT: String utilities


__END__
=pod

=head1 NAME

SHARYANTO::String::Util - String utilities

=head1 VERSION

version 0.17

=head1 FUNCTIONS

=head2 trim_blank_lines($str) => STR

Trim blank lines at the beginning and the end. Won't trim blank lines in the
middle. Blank lines include lines with only whitespaces in them.

=head1 FUNCTIONS

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

