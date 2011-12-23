use Test::More tests => 6;
use strict;
use warnings;
use_ok('ClubSpain::Model::Itinerary');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;

my $MOW = $helper->moscow();
my $BCN = $helper->barcelona();
my @dates = ClubSpain::Test->three_saturdays_ahead();

{
    my $iterator = $schema->resultset('ViewItineraryOW')->searchDatesOfDeparture(
        cityOfDeparture => $MOW->id,
        cityOfArrival   => $BCN->id,
    );

    is($iterator->count, 1, 'got date of departure');
    is($iterator->next->get_column('dateOfDeparture'), $dates[0]->ymd, 'got date of departure');
}

{
    use_ok('ClubSpain::Model::Itinerary');
    my $iterator = ClubSpain::Model::Itinerary->searchDatesOfDepartureOW(
        cityOfDeparture => $MOW->id,
        cityOfArrival   => $BCN->id,
    );

    is($iterator->count, 1, 'got date of departure');
    is($iterator->next->get_column('dateOfDeparture'), $dates[0]->ymd, 'got date of departure');
}
