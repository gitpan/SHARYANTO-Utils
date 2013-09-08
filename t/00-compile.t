use strict;
use warnings;

# This test was generated via Dist::Zilla::Plugin::Test::Compile 2.018

use Test::More 0.88;



use Capture::Tiny qw{ capture };

my @module_files = qw(
SHARYANTO/Array/Util.pm
SHARYANTO/Color/Util.pm
SHARYANTO/Data/OldUtil.pm
SHARYANTO/Data/Util.pm
SHARYANTO/File/Flock.pm
SHARYANTO/File/Util.pm
SHARYANTO/Getopt/Long/Util.pm
SHARYANTO/HTML/Extract/ImageLinks.pm
SHARYANTO/HTTP/DetectUA/Simple.pm
SHARYANTO/Hash/Util.pm
SHARYANTO/Log/Util.pm
SHARYANTO/ModuleOrPrefix/Path.pm
SHARYANTO/Number/Util.pm
SHARYANTO/Package/Util.pm
SHARYANTO/Proc/ChildError.pm
SHARYANTO/Proc/Daemon/Prefork.pm
SHARYANTO/Proc/Util.pm
SHARYANTO/Role/Doc/Section.pm
SHARYANTO/Role/Doc/Section/AddTextLines.pm
SHARYANTO/Role/I18N.pm
SHARYANTO/Role/I18NMany.pm
SHARYANTO/Role/I18NRinci.pm
SHARYANTO/Scalar/Util.pm
SHARYANTO/Template/Util.pm
SHARYANTO/Text/Prompt.pm
SHARYANTO/Utils.pm
SHARYANTO/YAML/Any.pm
SHARYANTO/YAML/Any_SyckOnly.pm
SHARYANTO/YAML/Any_YAMLAny.pm
);

my @scripts = qw(

);

# no fake home requested

my @warnings;
for my $lib (@module_files)
{
    my ($stdout, $stderr, $exit) = capture {
        system($^X, '-Mblib', '-e', qq{require q[$lib]});
    };
    is($?, 0, "$lib loaded ok");
    warn $stderr if $stderr;
    push @warnings, $stderr if $stderr;
}



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};



done_testing;
