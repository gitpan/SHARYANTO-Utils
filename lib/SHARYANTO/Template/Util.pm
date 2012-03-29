package SHARYANTO::Template::Util;

use 5.010;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(process_tt_recursive);

use File::Find;
use File::Slurp;
use Template::Tiny;

our $VERSION = '0.20'; # VERSION

# recursively find *.tt and process them. can optionally delete the *.tt files
# after processing.
sub process_tt_recursive {
    my ($dir, $vars, $opts) = @_;
    $opts //= {};
    my $tt = Template::Tiny->new;
    find sub {
        return unless -f;
        return unless /\.tt$/;
        my $newname = $_; $newname =~ s/\.tt$//;
        my $input = read_file($_);
        my $output;
        #$log->debug("Processing template $File::Find::dir/$_ -> $newname ...");
        $tt->process(\$input, $vars, \$output);
        write_file($newname, $output);
        #$log->debug("Removing $File::Find::dir/$_ ...");
        if ($opts->{delete}) { unlink($_) }
    }, $dir;
}

1;
# ABSTRACT: Recursively process .tt files

__END__
=pod

=head1 NAME

SHARYANTO::Template::Util - Recursively process .tt files

=head1 VERSION

version 0.20

=head1 FUNCTIONS

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

