package SHARYANTO::Hash::Util;

use 5.010;
use strict;
use warnings;
use Data::Clone;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(rename_key);

our $VERSION = '0.67'; # VERSION

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

=encoding UTF-8

=head1 NAME

SHARYANTO::Hash::Util - Hash utilities

=head1 VERSION

version 0.67

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
