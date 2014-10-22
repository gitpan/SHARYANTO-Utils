package SHARYANTO::Log::Util;

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(@log_levels $log_levels_re);

our $VERSION = '0.53'; # VERSION

our @log_levels = (qw/trace debug info warn error fatal/);
our $log_levels_re = join("|", @log_levels);
$log_levels_re = qr/\A(?:$log_levels_re)\z/;

1;
# ABSTRACT: Log-related utilities

__END__

=pod

=encoding utf-8

=head1 NAME

SHARYANTO::Log::Util - Log-related utilities

=head1 VERSION

version 0.53

=head1 SYNOPSIS

 use SHARYANTO::Log::Util qw(@log_levels $log_levels_re);

=head1 DESCRIPTION

=head1 VARIABLES

None are exported by default, but they are exportable.

=head2 @log_levels

Contains log levels, from lowest to highest. Currently these are:

 (qw/trace debug info warn error fatal/)

They can be used as method names to L<Log::Any> ($log->debug, $log->warn, etc).

=head2 $log_levels_re

Contains regular expression to check valid log levels.

=head1 SEE ALSO

L<Log::Any>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=cut
