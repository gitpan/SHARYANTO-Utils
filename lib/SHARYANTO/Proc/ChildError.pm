package SHARYANTO::Proc::ChildError;
BEGIN {
  $SHARYANTO::Proc::ChildError::VERSION = '0.01';
}
# ABSTRACT: Explain process child error

use 5.010;
require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(explain_child_error);

# taken from perldoc -f system

sub explain_child_error {
    my $e = shift // $?;

    if ($e == -1) {
        return "failed to execute: $e";
    } elsif ($e & 127) {
        return sprintf(
            "died with signal %d, %s coredump",
            ($e & 127),
            (($e & 128) ? 'with' : 'without'));
    } else {
        return "exited with value %d", $e >> 8;
    }
}

1;

__END__
=pod

=head1 NAME

SHARYANTO::Proc::ChildError - Explain process child error

=head1 VERSION

version 0.01

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

