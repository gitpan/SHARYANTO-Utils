package SHARYANTO::Hash::Util;

use 5.010;
use strict;
use warnings;
use Data::Clone;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(rename_key);

our $VERSION = '0.62'; # VERSION

sub rename_key {
    my ($h, $okey, $nkey) = @_;
    die unless    exists $h->{$okey};
    die if        exists $h->{$nkey};
    $h->{$nkey} = delete $h->{$okey};
}

1;
# ABSTRACT: Hash utilities

__END__

=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Hash::Util - Hash utilities

=head1 VERSION

version 0.62

=head1 SYNOPSIS

 use SHARYANTO::Hash::Util qw(rename_key);
 my %h = (a=>1, b=>2);
 rename_key(\%h, "a", "alpha"); # %h = (alpha=>1, b=>2)

=head1 FUNCTIONS

=head2 rename_key(\%hash, $old_key, $new_key)

Rename key. This is basically C<< $hash{$new_key} = delete $hash{$old_key} >>
with a couple of additional checks. It is a shortcut for:

 die unless exists $hash{$old_key};
 die if     exists $hash{$new_key};
 $hash{$new_key} = delete $hash{$old_key};


None are exported by default, but they are exportable.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DESCRIPTION

=cut
