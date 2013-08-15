# @(#)$Ident: Build.PL 2013-08-15 10:10 pjf ;

use strict;
use warnings;

use File::Spec::Functions qw( splitdir splitpath );
use Module::Build;

sub whimper { print {*STDOUT} $_[ 0 ]."\n"; exit 0 }

my $perl_ver = 5.008;
my $module   = 'lib/Dist/Zilla/Plugin/ManifestInRoot.pm';

$] >= $perl_ver or $ENV{PERL5_CPANPLUS_IS_VERSION}
   or whimper "Minimum required Perl version is ${perl_ver}";

Module::Build->subclass( code => do { local $/; <DATA> } )->new(
  'module_name' => __module_name2package_name( $module ),
  'notes'       => { min_perl_version => $perl_ver },
  'build_requires' => {
    'Dist::Zilla' => '4.300033',
    'Module::Build' => '0.4004',
    'version' => '0.88'
  },
  'configure_requires' => {
    'Module::Build' => '0.4004',
    'version' => '0.88'
  },
  'requires' => {
    'Dist::Zilla' => '4.300033',
    'File::Slurp' => '9999.13',
    'Moose' => '2.0802',
    'Moose::Autobox' => '0.12',
    'namespace::autoclean' => '0.13',
    'perl' => '5.008',
    'version' => '0.88'
  },

)->create_build_script;

exit 0;

sub __module_name2package_name {
   my $module = shift; $module =~ s{ \.pm \z }{}mx;
   my (undef, $dir, $file) = splitpath( $module );
   my @dirs   = splitdir( $dir ); shift @dirs; length $dirs[ -1 ] or pop @dirs;

   return join '::', @dirs, $file;
}

__DATA__

sub _normalize_prereqs { # Dynamic config
   my $self = shift; my $p = $self->SUPER::_normalize_prereqs; return $p;
}
