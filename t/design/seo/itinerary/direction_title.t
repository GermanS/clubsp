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

my $schema = $helper->schema();
my $MOW_BCN_OW = $schema->resultset('Itinerary')->search({ id => 1 })->single();

{
    my $expected = 'Стоимость авиабилета Москва - Барселона';
    is($seo->direction_title($MOW_BCN_OW), $expected, 'got MOW-BCN OW title');
}
