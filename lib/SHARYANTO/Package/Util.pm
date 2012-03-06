package SHARYANTO::Package::Util;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(package_exists);

our $VERSION = '0.12'; # VERSION

sub package_exists {
    my $pkg = shift;

    return unless $pkg =~ /\A\w+(::\w+)*\z/;
    if ($pkg =~ s/::(\w+)\z//) {
        return ${$pkg . "::"}{$1 . "::"} ? 1:0;
    } else {
        return $::{$pkg . "::"} ? 1:0;
    }
}

1;
# ABSTRACT: Array-related utilities


__END__
=pod

=head1 NAME

SHARYANTO::Package::Util - Array-related utilities

=head1 VERSION

version 0.12

=head1 SYNOPSIS

 use SHARYANTO::Package::Util qw(package_exists);

 print "Package Foo::Bar exists" if package_exists("Foo::Bar");

=head1 DESCRIPTION

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

