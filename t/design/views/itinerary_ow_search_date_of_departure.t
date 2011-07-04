use Test::More tests => 6;
use strict;
use warnings;
use_ok('ClubSpain::Model::Itinerary');

use lib qw(t/lib);
use ClubSpain::Test;
my @dates = ClubSpain::Test->three_saturdays_ahead();
my $schema = ClubSpain::Test->init_schema();

my $MOW = $schema->resultset('City')->search({ id => 1 })->single();
my $BCN = $schema->resultset('City')->search({ id => 2 })->single();

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
