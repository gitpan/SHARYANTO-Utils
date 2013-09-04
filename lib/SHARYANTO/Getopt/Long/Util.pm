package SHARYANTO::Getopt::Long::Util;

use 5.010;
use strict;
use warnings;

our $VERSION = '0.54'; # VERSION

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(gospec2human);

sub gospec2human {
    my $go = shift;

    my $type = 'flag';
    if ($go =~ s/!$//) {
        $type = 'bool';
    } elsif ($go =~ s/(=\w)$//) {
        $type = $1;
    } elsif ($go =~ s/\+$//) {
        # also a flag, increment by one like --more --more --more
    } elsif ($go !~ /[A-Za-z0-9?]\z/) {
        die "Sorry, can't parse '$go' yet (probably invalid?)";
    }

    my $res = "";
    for (split /\|/, $go) {
        $res .= ", " if length($res);
        s/^--?//;
        if ($type eq 'bool') {
            $res .= "--(no)$_";
        } else {
            if (length($_) > 1) {
                $res .= "--$_" . ($type =~ /^=/ ? $type : "");
            } else {
                $res .= "-$_" . ($type =~ /^=/ ? $type : "");
            }
        }
    }
    $res;
}

#ABSTRACT: Utilities for Getopt::Long

__END__

=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Getopt::Long::Util - Utilities for Getopt::Long

=head1 VERSION

version 0.54

=head1 FUNCTIONS

=head2 gospec2human($gospec) => STR

Change something like 'help|h|?' or 'foo=s' or 'debug!' into, respectively,
'--help, -h, -?' or '--foo=s' or '--(no)debug'. The output is suitable for
including in help/usage text.


None are exported by default, but they are exportable.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DESCRIPTION

=cut
