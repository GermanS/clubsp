use Test::More tests => 5;
use strict;
use warnings;
use_ok('ClubSpain::Model::LocalPhone');

my $params = {
    office_id => 1,
    number    => 4957831234,
    is_published => 1
};
my $phone = ClubSpain::Model::LocalPhone->new( $params );
isa_ok( $phone, 'ClubSpain::Model::LocalPhone' );

is $phone->get_office_id, $params->{'office_id'}
    => 'got office id';

is $phone->get_number, $params->{'number'}
    => 'got phone number';

is $phone->get_is_published, $params->{'is_published'}
    => 'got is published flag';
