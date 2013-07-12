package SHARYANTO::Data::OldUtil;

use 5.010;
use strict;
use warnings;
#use experimental 'smartmatch';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(has_circular_ref);

our $VERSION = '0.51'; # VERSION

our %SPEC;

$SPEC{has_circular_ref} = {
    v => 1.1,
    summary => 'Check whether data item contains circular references',
    description => <<'_',

Does not deal with weak references.

_
    args_as => 'array',
    args => {
        data => {
            schema => "any",
            pos => 0,
            req => 1,
        },
    },
    result_naked => 1,
};
sub has_circular_ref {
    my ($data) = @_;
    my %refs;
    my $check;
    $check = sub {
        my $x = shift;
        my $r = ref($x);
        return 0 if !$r;
        return 1 if $refs{"$x"}++;
        if ($r eq 'ARRAY') {
            for (@$x) {
                next unless ref($_);
                return 1 if $check->($_);
            }
        } elsif ($r eq 'HASH') {
            for (values %$x) {
                next unless ref($_);
                return 1 if $check->($_);
            }
        }
        0;
    };
    $check->($data);
}

1;
# ABSTRACT: Data utilities


__END__
=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Data::OldUtil - Data utilities

=head1 VERSION

version 0.51

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

None are exported by default, but they are exportable.


None are exported by default, but they are exportable.

=head2 has_circular_ref(@args) -> any

Check whether data item contains circular references.

Does not deal with weak references.

Arguments ('*' denotes required arguments):

=over 4

=item * B<data>* => I<any>

=back

Return value:

=head1 SEE ALSO

L<Data::Structure::Util> has the XS/C version of C<has_circular_ref> which is 3
times or more faster than this module's implementation which is pure Perl). Use
that instead.

This module is however much faster than L<Devel::Cycle>.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

