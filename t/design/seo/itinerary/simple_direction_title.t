use Test::More tests => 3;
use strict;
use warnings;
use utf8;

use lib qw(t/lib);
use ClubSpain::Test;

use_ok('ClubSpain::Model::SEO::Itinerary');

my $helper = ClubSpain::Test->new();
my $MOW = $helper->moscow();
my $BCN = $helper->barcelona();

my $seo = ClubSpain::Model::SEO::Itinerary->new();
isa_ok($seo, 'ClubSpain::Model::SEO::Itinerary');

{
    my $expected = 'Авиабилеты Москва - Барселона';
    my $got = $seo->simple_direction_title(
        cityOfDeparture => $MOW,
        cityOfArrival   => $BCN,
    );
    is($got, $expected, 'got simple direction title');
}

