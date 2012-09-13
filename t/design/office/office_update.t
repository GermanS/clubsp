use Test::More tests => 7;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Office');
#add account to database
{
    my $office = ClubSpain::Model::Office->new(
        company_id  => 1,
        zipcode     => 654321,
        street      => 'Address 22',
        name        => 'Office 3',
        is_published => 0,
    );
    $office->create();
}

my $params = {
    id   => 1,
    company_id  => 1,
    zipcode     => 123456,
    street      => 'Address 20',
    name        => 'Office 1',
    is_published => 1,
};

my $office = ClubSpain::Model::Office->new( $params );
my $result = $office->update();

isa_ok($result, 'ClubSpain::Schema::Result::Office');
is $result->company_id, $params->{'company_id'}
    => 'got company id';
is $result->zipcode, $params->{'zipcode'}
    => 'got zipcode';
is $result->name, $params->{'name'}
    => 'got name';
is $result->street, $params->{'street'}
    => 'got street';
is $result->is_published, $params->{'is_published'}
    => 'got is published flag';
