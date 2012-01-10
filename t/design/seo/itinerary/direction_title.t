use Test::More tests => 6;
use strict;
use warnings;
use utf8;

use lib qw(t/lib);
use ClubSpain::Test;

use_ok('ClubSpain::Model::SEO::Itinerary');

my $helper = ClubSpain::Test->new();

my $seo = ClubSpain::Model::SEO::Itinerary->new();
isa_ok($seo, 'ClubSpain::Model::SEO::Itinerary');

my @date = $helper->three_saturdays_ahead();
my $MOW_BCN_OW = $helper->MOW_BCN_Y_OW();
my $MOW_BCN_RT = $helper->MOW_BCN_MOW_Y_NN331_NN332();

{
    my $expected = 'Авиабилеты Москва - Барселона';
    is($seo->direction_title($MOW_BCN_OW), $expected, 'got MOW-BCN title');
}

{
    my $expected = 'Авиабилеты Москва - Барселона - Москва';
    is($seo->direction_title($MOW_BCN_RT), $expected, 'got MOW-BCN-MOW title');
}

{
    my $expected = 'Авиабилеты Москва - Барселона, вылет ' . $date[0]->ymd;
    is($seo->direction_title_with_date($MOW_BCN_OW), $expected, 'got MOW-BCN title with date');
}

{
    my $expected = 'Авиабилеты Москва - Барселона - Москва c ' . $date[0]->ymd . ' по ' . $date[1]->ymd;
    is($seo->direction_title_with_date($MOW_BCN_RT), $expected, 'got MOW-BCN-MOW title with date');
}

