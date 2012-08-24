package SHARYANTO::Role::I18NRinci;

use 5.010;
use Log::Any '$log';
use Moo::Role;
use Perinci::Object;

our $VERSION = '0.26'; # VERSION

with 'SHARYANTO::Role::I18N';

requires 'lang';

sub langprop {
    my ($self, $meta, $prop) = @_;
    my $opts = {
        lang=>$self->lang,
    };
    rimeta($meta)->langprop($prop, $opts);
}

1;
# ABSTRACT: Role for class that wants to work with language and Rinci metadata

__END__
=pod

=head1 NAME

SHARYANTO::Role::I18NRinci - Role for class that wants to work with language and Rinci metadata

=head1 VERSION

version 0.26

=head1 FUNCTIONS

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

