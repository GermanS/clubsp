use strict;
use warnings;

use lib qw(lib);

use ClubSpain::Build;

my $build = ClubSpain::Build->new(
    module_name          => 'ClubSpain',
    recursive_test_files => 1,
    requires => {
        'Cache::FastMmap'                            => '>=1.40',
        'Catalyst'                                   => '>=5.80025',
        'Catalyst::Model::DBIC::Schema'              => 0,
#        'Catalyst::Model::SOAP'                      => '>=1.5',
        'Catalyst::Plugin::Authentication'           => '>=0.10021',
        'Catalyst::Plugin::Cache'                    => '>=0.11',
#        'Catalyst::Plugin::Server'                   => '>=0.28',
#        'Catalyst::Plugin::Server::XMLRPC'           => 0,
        'Catalyst::Plugin::Session'                  => '>=0.35',
        'Catalyst::Plugin::Session::Store::FastMmap' => '0',
        'Catalyst::Plugin::Unicode'                  => 0,
        'Catalyst::View::JSON'                       => 0,
        'Config::General'                            => 0,
        'Data::Page'                                 => 0,
        'Data::Page::FlickrLike'                     => 0,
        'DateTime'                                   => 0,
        'DateTime::Format::MySQL'                    => 0,
        'DBD::SQLite'                                => '>=1.29',
        'DBIx::Class'                                => '>=0.08123',
        'Exception::Class'                           => 0,
        'HTML::FormHandler'                          => 0,
        'Moose'                                      => '>=1.09',
        'MooseX::ClassAttribute'                     => '>=0.27',
        'MooseX::MethodAttributes'                   => 0,
        'MooseX::Singleton'                          => 0,
        'SQL::Translator'                            => '>=0.11006',
        'Test::More'                                 => '>=0.94',
        'Text::GooglewikiFormat'                     => '0',
        'XML::Compile'                               => '>=1.16',
        'XML::Compile::SOAP'                         => '>=2.16',
        'XML::Compile::Transport::SOAPHTTP'          => 0,
        'XML::Compile::WSDL11'                       => 0,
        'XML::LibXML'                                => '>=1.70',
    }
);

$build->create_build_script();
