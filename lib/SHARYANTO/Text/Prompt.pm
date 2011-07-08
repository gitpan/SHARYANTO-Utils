package SHARYANTO::Text::Prompt;
BEGIN {
  $SHARYANTO::Text::Prompt::VERSION = '0.03';
}
# ABSTRACT: Prompt user question

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(prompt);


sub prompt {
    my ($text, $opts) = @_;
    $opts //= {};
    my $answer;

    my $default;
    if ($opts->{var}) {
    }
    $default = ${$opts->{var}} if $opts->{var};
    $default = $opts->{default} if defined($opts->{default});

    while (1) {
        # prompt
        print $text;
        print " ($default)" if defined($default);
        print ":" unless $text =~ /[:?]\s*$/;
        print " ";

        # get input
        $answer = <STDIN>;
        if (!defined($answer)) {
            print "\n";
            $answer = "";
        }
        chomp($answer);

        # check+process answer
        if (defined($default)) {
            $answer = $default if !length($answer);
        }
        my $success = 1;
        if ($opts->{required}) {
            $success = 0 if !length($answer);
        }
        if ($opts->{regex}) {
            $success = 0 if $answer !~ /$opts->{regex}/;
        }
        last if $success;
    }
    ${$opts->{var}} = $answer if $opts->{var};
    $answer;
}

1;

__END__
=pod

=head1 NAME

SHARYANTO::Text::Prompt - Prompt user question

=head1 VERSION

version 0.03

=head1 FUNCTIONS

=head2 prompt($text, \%opts)

Options:

=over 4

=item * var => \$var

=item * required => \$var

=item * default => VALUE

=item * regex => REGEX

=back

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

