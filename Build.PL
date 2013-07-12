
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::chdir" => 0,
    "Module::Build" => "0.3601",
    "Test::Exception" => 0,
    "Test::More" => "0.98"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "SHARYANTO's temporary namespace for various routines",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "SHARYANTO-Utils",
  "dist_version" => "0.51",
  "license" => "perl",
  "module_name" => "SHARYANTO::Utils",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Data::Clone" => 0,
    "Data::Structure::Util" => 0,
    "File::Slurp" => 0,
    "File::Which" => 0,
    "HTML::Parser" => 0,
    "Locale::Maketext::Lexicon" => 0,
    "Log::Any" => 0,
    "Moo::Role" => 0,
    "Parse::Netstat" => 0,
    "Perinci::Object" => "0.07",
    "Rinci" => "v1.1.0",
    "Template::Tiny" => 0,
    "URI::URL" => 0,
    "YAML::Syck" => 0,
    "experimental" => 0,
    "perl" => "5.010001"
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
