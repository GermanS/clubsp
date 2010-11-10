use strict;
use warnings;

use lib qw(lib);

use ClubSpain::Build;

my $build = ClubSpain::Build->new(
    module_name => 'ClubSpain',
    recursive_test_files => 1,
    requires => {
        'Catalyst'                              => '>=5.80025',
        'Catalyst::Controller::HTML::FormFu'    => '>=0.06001',
        'Catalyst::Model::SOAP'                 => '>=1.5',
        'Catalyst::Plugin::Server'              => '>=0.28',
        'Config::General'                       => 0,
        'DBD::SQLite'                           => '>=1.29',
        'DBIx::Class'                           => '>=0.08123',
        'HTML::FormFu'                          => '>=0.07002',
        'Moose'                                 => '>=1.09',
        'MooseX::Singleton'                     =>  0,
        'SQL::Translator'                       => '>=0.11006',
        'Test::More'                            => '>=0.94',
        'XML::Compile'                          => '>=1.16',
        'XML::Compile::SOAP'                    => '>=2.16',
        'XML::LibXML'                           => '>=1.70',
    }
);

$build->create_build_script();
