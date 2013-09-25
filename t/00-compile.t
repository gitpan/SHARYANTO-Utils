use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.033

use Test::More  tests => 22 + ($ENV{AUTHOR_TESTING} ? 1 : 0);



my @module_files = (
    'SHARYANTO/Array/Util.pm',
    'SHARYANTO/ColorTheme/Util.pm',
    'SHARYANTO/Getopt/Long/Util.pm',
    'SHARYANTO/HTML/Extract/ImageLinks.pm',
    'SHARYANTO/HTTP/DetectUA/Simple.pm',
    'SHARYANTO/Hash/Util.pm',
    'SHARYANTO/Log/Util.pm',
    'SHARYANTO/ModuleOrPrefix/Path.pm',
    'SHARYANTO/Proc/ChildError.pm',
    'SHARYANTO/Proc/Daemon/Prefork.pm',
    'SHARYANTO/Role/BorderStyle.pm',
    'SHARYANTO/Role/ColorTheme.pm',
    'SHARYANTO/Role/Doc/Section.pm',
    'SHARYANTO/Role/Doc/Section/AddTextLines.pm',
    'SHARYANTO/Role/I18N.pm',
    'SHARYANTO/Role/I18NMany.pm',
    'SHARYANTO/Role/I18NRinci.pm',
    'SHARYANTO/Role/TermAttrs.pm',
    'SHARYANTO/Scalar/Util.pm',
    'SHARYANTO/Template/Util.pm',
    'SHARYANTO/Text/Prompt.pm',
    'SHARYANTO/Utils.pm'
);



# no fake home requested

use File::Spec;
use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, '-Mblib', '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($? >> 8, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};


