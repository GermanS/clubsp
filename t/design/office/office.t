use Test::More tests => 7;
use strict;
use warnings;

use_ok('ClubSpain::Model::Office');

my $params = {
    company_id  => 1,
    zipcode     => 123456,
    street      => 'Address 20',
    name        => 'Office 1',
    is_published => 1,
};
my $office = ClubSpain::Model::Office->new( $params );
isa_ok $office, 'ClubSpain::Model::Office';
is $office->get_company_id, $params->{'company_id'}
    => 'got company id';
is $office->get_zipcode, $params->{'zipcode'}
    => 'got zipcode';
is $office->get_name, $params->{'name'}
    => 'got name';
is $office->get_street, $params->{'street'}
    => 'got street';
is $office->get_is_published, $params->{'is_published'}
    => 'got is published flag';
