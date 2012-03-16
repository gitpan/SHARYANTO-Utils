package SHARYANTO::Package::Util;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(package_exists);

our $VERSION = '0.15'; # VERSION

sub package_exists {
    my $pkg = shift;

    return unless $pkg =~ /\A\w+(::\w+)*\z/;
    if ($pkg =~ s/::(\w+)\z//) {
        return !!${$pkg . "::"}{$1 . "::"};
    } else {
        return !!$::{$pkg . "::"};
    }
}

1;
# ABSTRACT: Package-related utilities


__END__
=pod

=head1 NAME

SHARYANTO::Package::Util - Package-related utilities

=head1 VERSION

version 0.15

=head1 SYNOPSIS

 use SHARYANTO::Package::Util qw(package_exists);

 print "Package Foo::Bar exists" if package_exists("Foo::Bar");

=head1 DESCRIPTION

=head1 FUNCTIONS

None are exported by default, but they can be.

=head2 package_exists($name) => BOOL

Return true if package "exists". By "exists", it means that the package has been
defined by C<package> statement or some entries have been created in the symbol
table (e.g. C<$Foo::var = 1;> will make the C<Foo> package "exist").

This function can be used e.g. for checking before aliasing one package to
another. Or to casually check whether a module has been loaded.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

