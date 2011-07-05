package SHARYANTO::HTML::Extract::ImageLinks;
BEGIN {
  $SHARYANTO::HTML::Extract::ImageLinks::VERSION = '0.02';
}
# ABSTRACT: Extract image links from HTML document

use 5.010;
use strict;
use warnings;

use HTML::Parser;
use URI::URL;

use Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(extract_image_links);

our %SPEC;

$SPEC{extract_image_links} = {
    summary => 'Extract image links from HTML document',
    description => <<'_',

Either specify either url, html.

_
    args => {
        html => ['str' => {
            summary => 'HTML document to extract from',
            arg_from_stdin => 1,
        }],
        base => ['str' => {
            summary => 'base URL for images',
        }],
    },
};
sub extract_image_links {
    my %args = @_;

    my $html = $args{html};
    defined($html) or return [400, "Please specify html"];
    my $base = $args{base};

    # get base from <BASE HREF> if exists
    if (!$base) {
        if ($html =~ /<base\b[^>]*\bhref\s*=\s*(["']?)(\S+?)\1[^>]*>/is) {
            $base = $2;
        }
    }

    my %memory;
    my @res;
    my $p = HTML::Parser->new(
        api_version => 3,
        start_h => [
            sub {
                my ($tagname, $attr) = @_;
                return unless $tagname =~ /^img$/i;
                for ($attr->{src}) {
                    s/#.*//;
                    if (++$memory{$_} == 1) {
                        push @res, URI::URL->new($_, $base)->abs()->as_string;
                    }
                }
            }, "tagname, attr"],
    );
    $p->parse($html);

    [200, "OK", \@res];
}

1;


=pod

=head1 NAME

SHARYANTO::HTML::Extract::ImageLinks - Extract image links from HTML document

=head1 VERSION

version 0.02

=head1 FUNCTIONS

None are exported by default, but they are exportable.

=head2 extract_image_links(%args) -> [STATUS_CODE, ERR_MSG, RESULT]


Extract image links from HTML document.

Either specify either url, html.

Returns a 3-element arrayref. STATUS_CODE is 200 on success, or an error code
between 3xx-5xx (just like in HTTP). ERR_MSG is a string containing error
message, RESULT is the actual result.

Arguments (C<*> denotes required arguments):

=over 4

=item * B<base> => I<str>

base URL for images.

=item * B<html> => I<str>

HTML document to extract from.

=back

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

