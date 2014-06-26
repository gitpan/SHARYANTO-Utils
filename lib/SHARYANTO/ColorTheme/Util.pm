package SHARYANTO::ColorTheme::Util;

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(create_color_theme_transform);

our $VERSION = '0.75'; # VERSION

sub create_color_theme_transform {
    my ($basect, $func) = @_;

    my $derivedct = {};

    for my $cn (keys %{ $basect->{colors} }) {
        my $cv = $basect->{colors}{$cn};

        if ($cv) {
            $derivedct->{colors}{$cn} = sub {
                my ($self, %args) = @_;
                my $basec = $basect->{colors}{$cn};
                if (ref($basec) eq 'CODE') {
                    $basec = $basec->($self, name=>$cn, %args);
                }
                if ($basec) {
                    if (ref($basec) eq 'ARRAY') {
                        $basec = [map {defined($_) && /^#?[0-9A-Fa-f]{6}$/ ?
                                           $func->($_) : $_} @$basec];
                    } else {
                        for ($basec) {
                            $_ = defined($_) && /^#?[0-9A-Fa-f]{6}$/ ?
                                $func->($_) : $_;
                        }
                    }
                }
                return $basec;
            };
        } else {
            #$derivedct->{colors}{$cn} = $cv;
        }
    }
    $derivedct;
}

1;
# ABSTRACT: Utility routines

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::ColorTheme::Util - Utility routines

=head1 VERSION

This document describes version 0.75 of SHARYANTO::ColorTheme::Util (from Perl distribution SHARYANTO-Utils), released on 2014-06-26.

=head1 FUNCTIONS

=head2 create_color_theme_transform($basect, $func) => HASH

Create a new color theme by applying transform function C<$func> (code) to base
theme C<$basect> (hash). For example if you want to create a reddish color theme
from the default theme:

 use Text::ANSITable;
 use SHARYANTO::Color::Util qw(mix_2_rgb_colors);
 use SHARYANTO::ColorTheme::Util qw(create_color_theme_transform);

 my $basect = Text::ANSITable->get_color_theme("Default::default_gradation");
 my $redct  = create_color_theme_transform(
     $basect, sub { mix_2_rgb_colors(shift, 'ff0000') });

 # use the color theme
 my $t = Text::ANSITable->new;
 $t->color_theme($redct);

=head1 SEE ALSO

L<SHARYANTO>

For more information about color themes, see L<SHARYANTO::Role::ColorTheme>.

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
