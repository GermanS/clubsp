use Test::More tests => 10;
use strict;
use warnings;
use utf8;

use_ok('ClubSpain::XML::VipService::Config');

{
    my %params = (
        locale              => 'locale_value',
        loginName           => 'login_name_value',
        password            => 'password_value',
        salesPointCode      => 'sales_point_code_value',
        corporateClientCode => 'corporate_client_value',
        wsdlfile => '/path/to/wsdl',
        xsdfile  => '/path/to/xsd',
    );
    my $config = ClubSpain::XML::VipService::Config->new( %params );

    isa_ok($config, 'ClubSpain::XML::VipService::Config');
    is($config->locale, 'locale_value', 'got locale');
    is($config->loginName, 'login_name_value', 'git login');
    is($config->password, 'password_value', 'got password');
    is($config->salesPointCode, 'sales_point_code_value', 'got salesPointCode');
    is($config->corporateClientCode, 'corporate_client_value', 'got corporateClientCode');
    is($config->wsdlfile, '/path/to/wsdl', 'got wsdlfile');
    is($config->xsdfile, '/path/to/xsd', 'got xsdfile');


    delete $params{'wsdlfile'} && delete $params{'xsdfile'};
    is_deeply($config->to_hash,  \%params, 'got context hash');
}

=head

use Catalyst::Test qw(ClubSpain);

use Data::Dumper;
warn Dumper(ClubSpain->config);

my $config = ClubSpain::XML::VipService::Config->new(ClubSpain->config->{'XML::VipService::Config'});
warn Dumper($config);

=cut
