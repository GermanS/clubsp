use Test::More tests => 16;

use strict;
use warnings;
use utf8;

use_ok('ClubSpain::XML::VipService::Config');

{
    my %params = (
#        corporateClientCode => 'corporate_client_value',
        locale         => 'locale_value',
        loginName      => 'login_name_value',
        password       => 'password_value',
        salesPointCode => 'sales_point_code_value',
        wsdlfile       => '/path/to/wsdl',
        xsdfile        => '/path/to/xsd',
    );
    my $config = ClubSpain::XML::VipService::Config -> new( %params );

    isa_ok($config, 'ClubSpain::XML::VipService::Config');

    is $config -> locale, 'locale_value'
        => 'got locale';

    is $config -> loginName, 'login_name_value'
        => 'got login';

    is $config -> password, 'password_value'
        => 'got password';

    is $config -> salesPointCode, 'sales_point_code_value'
        => 'got salesPointCode';

    is $config -> wsdlfile, '/path/to/wsdl'
        => 'got wsdlfile';

    is $config -> xsdfile, '/path/to/xsd'
        => 'got xsdfile';
#    is($config->corporateClientCode, 'corporate_client_value', 'got corporateClientCode');

    delete $params{'wsdlfile'} && delete $params{'xsdfile'};
    is_deeply $config -> to_hash,  \%params,
            => 'got context hash';
}


#pass config like catalyst
{
    my $config = ClubSpain::XML::VipService::Config->new(
        config => {
            'XML::VipService::Config' => {
#                corporateClientCode => 'cfg_corporate_client_value',
                locale         => 'cfg_locale_value',
                loginName      => 'cfg_login_name_value',
                password       => 'cfg_password_value',
                salesPointCode => 'cfg_sales_point_code_value',
                wsdlfile       => '/cfg/path/to/wsdl',
                xsdfile        => '/cfg/path/to/xsd',
            }
       }
    );

    isa_ok($config, 'ClubSpain::XML::VipService::Config');
#   is($config->corporateClientCode, 'cfg_corporate_client_value', 'got corporateClientCode');

    is $config -> locale, 'cfg_locale_value'
        => 'got locale';

    is $config -> loginName, 'cfg_login_name_value'
        => 'get login';

    is $config -> password, 'cfg_password_value'
        => 'got password';
    is $config -> salesPointCode, 'cfg_sales_point_code_value'
        => 'got salesPointCode';

    is $config -> wsdlfile, '/cfg/path/to/wsdl'
        => 'got wsdlfile';

    is $config -> xsdfile, '/cfg/path/to/xsd'
        => 'got xsdfile';
}