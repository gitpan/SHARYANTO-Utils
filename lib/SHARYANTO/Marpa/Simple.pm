package SHARYANTO::Marpa::Simple;

use Marpa::R2;
use UUID::Random;

use Exporter qw(import);
our @EXPORT_OK = qw(gen_parser);

our $VERSION = '0.72'; # VERSION
our $DATE = '2014-05-08'; # DATE

our %SPEC;

$SPEC{gen_parser} = {
    v => 1.1,
    summary => 'Generate Marpa-based parser',
    args => {
        grammar => {
            summary => '',
            schema  => 'str*',
            req => 1,
            pos => 0,
        },
        actions => {
            summary => '',
            schema  => ['hash*', each_value => 'code*'],
        },
    },
    result_naked => 1,
    result => {
        schema => 'code*',
    },
};
sub gen_parser {
    no strict 'refs';

    my %args = @_;

    my $grammar = Marpa::R2::Scanless::G->new({source => \$args{grammar} });
    my $pkg = __PACKAGE__ . '::gen' . substr(UUID::Random::generate(), 0, 8);
    my $acts = $args{actions};
    for (keys %$acts) {
        *{"$pkg\::$_"} = $acts->{$_};
    }

    my $parser = sub {
        my $input = shift;

        my $recce = Marpa::R2::Scanless::R->new({
            grammar => $grammar,
            semantics_package => $pkg,
        });
        $recce->read(\$input);
        my $valref = $recce->value;
        if (!defined($valref)) {
            die "No parse was found after reading the entire input\n";
            # XXX show last expression
        }
        $$valref;
    };

    $parser;
}

1;
# ABSTRACT: Generate Marpa-based parser

__END__

=pod

=encoding UTF-8

=head1 NAME

SHARYANTO::Marpa::Simple - Generate Marpa-based parser

=head1 VERSION

This document describes version 0.72 of SHARYANTO::Marpa::Simple (from Perl distribution SHARYANTO-Utils), released on 2014-05-08.

=head1 SYNOPSIS

 use SHARYANTO::Marpa::Simple qw(gen_parser);

 my $parser = gen_parser(
     grammar => <<'EOG',
 :start     ::= expr
 expr       ::= num
              | num '+' num    action => do_add
 num        ~ [\d]+
 :discard   ~ whitespace
 whitespace ~ [\s]+
 EOG
     actions => {
         do_add => sub { shift; $_[0] + $_[2] }
     },
 );

 print $parser->('3 + 4'); # -> 7
 print $parser->('3 + ');  # dies with parse error

which is a shortcut for roughly this:

 no strict 'refs';
 use Marpa::R2;
 my $grammar = Marpa::R2::Scanless::G->new({source => \$args{grammar}});
 my $pkg = "SHARYANTO::Marpa::Simple::gen" . some_random_value();
 my $actions = $args{actions};
 for (keys %$actions) {
     ${"$pkg\::$_"} = $actions->{$_};
 }
 my $parser = sub {
     my $input = shift;
     my $recce = Marpa::R2::Scanless::R->new({
         grammar => $grammar,
         semantics_package => $pkg,
     });
 };

=head1 FUNCTIONS


=head2 gen_parser(%args) -> code

Generate Marpa-based parser.

Arguments ('*' denotes required arguments):

=over 4

=item * B<actions> => I<hash>

=item * B<grammar>* => I<str>

=back

Return value:

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
