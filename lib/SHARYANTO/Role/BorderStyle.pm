package SHARYANTO::Role::BorderStyle;

use 5.010;
use Moo::Role;

our $VERSION = '0.57'; # VERSION

with 'SHARYANTO::Role::TermAttrs';

has border_style_args  => (is => 'rw', default => sub { {} });
has _all_border_styles => (is => 'rw');

sub border_style {
    my $self = shift;

    if (!@_) { return $self->{border_style} }
    my $bs = shift;

    my $p2 = "";
    if (!ref($bs)) {
        $p2 = " named $bs";
        $bs = $self->get_border_style($bs);
    }

    my $err;
    if ($bs->{box_chars} && !$self->use_box_chars) {
        $err = "use_box_chars is set to false";
    } elsif ($bs->{utf8} && !$self->use_utf8) {
        $err = "use_utf8 is set to false";
    }
    die "Can't select border style$p2: $err" if $err;

    $self->{border_style} = $bs;
}

sub get_border_style {
    my ($self, $bs) = @_;

    my $prefix = (ref($self) ? ref($self) : $self ) .
        '::BorderStyle'; # XXX allow override

    my $bss;
    my $pkg;
    if ($bs =~ s/(.+):://) {
        $pkg = "$prefix\::$1";
        my $pkgp = $pkg; $pkgp =~ s!::!/!g;
        require "$pkgp.pm";
        no strict 'refs';
        $bss = \%{"$pkg\::border_styles"};
    } else {
        #$bss = $self->list_border_styles(1);
        die "Please use SubPackage::name to choose border style, ".
            "use list_border_styles() to list available styles";
    }
    $bss->{$bs} or die "Unknown border style name '$bs'".
        ($pkg ? " in package $prefix\::$pkg" : "");
    $bss->{$bs};
}

sub list_border_styles {
    require Module::List;
    require Module::Load;

    my ($self, $detail) = @_;

    my $prefix = (ref($self) ? ref($self) : $self ) .
        '::BorderStyle'; # XXX allow override
    my $all_bs = $self->_all_border_styles;

    if (!$all_bs) {
        my $mods = Module::List::list_modules("$prefix\::",
                                              {list_modules=>1});
        no strict 'refs';
        $all_bs = {};
        for my $mod (sort keys %$mods) {
            #$log->tracef("Loading border style module '%s' ...", $mod);
            Module::Load::load($mod);
            my $bs = \%{"$mod\::border_styles"};
            for (keys %$bs) {
                my $cutmod = $mod;
                $cutmod =~ s/^\Q$prefix\E:://;
                my $name = "$cutmod\::$_";
                $bs->{$_}{name} = $name;
                $all_bs->{$name} = $bs->{$_};
            }
        }
        $self->_all_border_styles($all_bs);
    }

    if ($detail) {
        return $all_bs;
    } else {
        return sort keys %$all_bs;
    }
}

1;
# ABSTRACT: Role for class wanting to support border styles

__END__

=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Role::BorderStyle - Role for class wanting to support border styles

=head1 VERSION

version 0.57

=head1 DESCRIPTION

This role is for class that wants to support border styles. For description
about border styles, currently please refer to L<Text::ANSITable>.

=head1 ATTRIBUTES

=head2 border_style => HASH

=head2 border_style_args => HASH

=head1 METHODS

=head2 $cl->get_border_style($name) => HASH

=head2 $cl->list_border_styles($detail) => ARRAY

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=cut
