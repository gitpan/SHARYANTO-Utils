package SHARYANTO::Timer::Simple;

use 5.010001;
use strict;
use warnings;
no strict 'refs';
no warnings 'once';

use Time::HiRes;
use Time::Stopwatch;

our $VERSION = '0.72'; # VERSION
our $DATE = '2014-05-08'; # DATE

tie our($TIMER), 'Time::Stopwatch';

sub timer(&) {
    local $TIMER = 0;
    shift->();
    say $TIMER;
}

sub import {
    my $class = shift;
    my $caller = caller;

    # this does not work, caller's $TIMER is not tied
    #${"$caller\::TIMER"} = $TIMER;
    tie ${"$caller\::TIMER"}, 'Time::Stopwatch';

    *{"$caller\::timer"} = \&timer;
}

1;
# ABSTRACT: Simple timer

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::Timer::Simple - Simple timer

=head1 VERSION

This document describes version 0.72 of SHARYANTO::Timer::Simple (from Perl distribution SHARYANTO-Utils), released on 2014-05-08.

=head1 SYNOPSIS

 use SHARYANTO::Timer::Simple; # exports timer() and $TIMER

 $TIMER = 0; do_something(); say $TIMER;
 timer { do_something_else() };

=head1 DESCRIPTION

This module exports C<timer> and C<$TIMER>. The former can be used to measure
the running time of a block of code, and the later is a shortcut/default for
L<Time::Stopwatch>.

=head1 EXPORTS

=head2 $TIMER

=head1 FUNCTIONS

=head2 timer CODE

Execute CODE and print the number of seconds passed.

=head1 SEE ALSO

L<Benchmark>, L<Bench>

L<Time::Stopwatch>

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
