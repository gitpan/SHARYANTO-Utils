package SHARYANTO::Role::I18N;

use 5.010;
use Log::Any '$log';
use Moo::Role;

our $VERSION = '0.58'; # VERSION

has lang => (
    is => 'rw',
    lazy => 1,
    default => sub {
        if ($ENV{LANG}) {
            my $l = $ENV{LANG}; $l =~ s/\W.*//;
            return $l;
        }
        if ($ENV{LANGUAGE}) {
            my $l = $ENV{LANGUAGE}; $l =~ s/\W.*//;
            return $l;
        }
        "en_US";
    },
);
has loc_class => (
    is => 'rw',
    default => sub {
        my $self = shift;
        ref($self) . '::I18N';
    },
);
has lh => (
    is => 'rw',
    lazy => 1,
    default => sub {
        require Module::Load;

        my $self = shift;
        Module::Load::load($self->loc_class);
        my $obj = $self->loc_class->new;
        my $lh = $obj->get_handle($self->lang)
            or die "Can't determine language";
        $lh;
    },
);

sub loc {
    my ($self, @args) = @_;
    $self->lh->maketext(@args);
}

sub locopt {
    my ($self, @args) = @_;
    my $res = eval {
        $self->lh->maketext(@args);
    };
    if ($@) {
        return $args[0];
    } else {
        return $res;
    }
}

1;
# ABSTRACT: Role for internationalized class

__END__

=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Role::I18N - Role for internationalized class

=head1 VERSION

version 0.58

=head1 DESCRIPTION

This role is for class that wants to provide localized text, using
L<Locale::Maketext>. It provides some convention and defaults.

=head1 ATTRIBUTES

=head2 lang

Defaults to LANG or LANGUAGE environment variable, or C<en_US>.

=head2 loc_class

Project class. Defaults to $class::I18N.

=head2 lh

The language handle, where you ask for localized text using
C<< lh->maketext(...) >>.

=head1 METHODS

=head2 $doc->loc(@args) => STR

Shortcut for C<< $doc->lh->maketext(@args) >>.

=head2 $doc->locopt(@args) => STR

Like loc(), but will trap missing translation. So instead of dying, it will
return $args[0] instead.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=cut
