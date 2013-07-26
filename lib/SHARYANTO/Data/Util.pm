package SHARYANTO::Data::Util;

use 5.010;
use strict;
use warnings;
#use experimental 'smartmatch';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(clone_circular_refs);

our $VERSION = '0.52'; # VERSION

our %SPEC;

$SPEC{clone_circular_refs} = {
    v => 1.1,
    summary => 'Remove circular references by deep-copying them',
    description => <<'_',

For example, this data:

    $x = [1];
    $data = [$x, 2, $x];

contains circular references by referring to `$x` twice. After
`clone_circular_refs`, data will become:

    $data = [$x, 2, [1]];

that is, the subsequent circular references will be deep-copied. This makes it
safe to transport to JSON, for example.

Sometimes it doesn't work, for example:

    $data = [1];
    push @$data, $data;

Cloning will still create circular references.

This function modifies the data structure in-place, and return true for success
and false upon failure.

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
sub clone_circular_refs {
    require Data::Structure::Util;
    require Data::Clone;

    my ($data) = @_;
    my %refs;
    my $doit;
    $doit = sub {
        my $x = shift;
        my $r = ref($x);
        return if !$r;
        if ($r eq 'ARRAY') {
            for (@$x) {
                next unless ref($_);
                if ($refs{"$_"}++) {
                    $_ = Data::Clone::clone($_);
                } else {
                    $doit->($_);
                }
            }
        } elsif ($r eq 'HASH') {
            for (keys %$x) {
                next unless ref($x->{$_});
                if ($refs{"$x->{$_}"}++) {
                    $x->{$_} = Data::Clone::clone($x->{$_});
                } else {
                    $doit->($_);
                }
            }
        }
    };
    $doit->($data);
    !Data::Structure::Util::has_circular_ref($data);
}

1;
# ABSTRACT: Data utilities

__END__

=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Data::Util - Data utilities

=head1 VERSION

version 0.52

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

None are exported by default, but they are exportable.


None are exported by default, but they are exportable.

=head2 clone_circular_refs() -> any

No arguments.

Return value:

=head1 SEE ALSO

To check for circular references, try C<has_circular_ref> from
L<Data::Structure::Util>. There is also L<Devel::Cycle> albeit far slower.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
