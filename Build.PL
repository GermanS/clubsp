use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
    module_name => 'ClubSpain',
    recursive_test_files => 1,
    requires => {
        'Config::General'                  => 0,
        'SQL::Translator'                  => '>=0.11006',
        'DBIx::Class'                      => '>=0.08123',
        'DBD::SQLite'                      => '>=1.29',
        'Test::More'                       => '>=0.94',
    }
);

$build->create_build_script();
