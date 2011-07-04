use Test::More tests => 5;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;

my @dates = ClubSpain::Test->three_saturdays_ahead();

my $schema = ClubSpain::Test->init_schema();

my $MOW = $schema->resultset('City')->search({ id => 1 })->single();
my $BCN = $schema->resultset('City')->search({ id => 2 })->single();

#MOW-BCN-BCN-MOW
{
    my $iterator = $schema->resultset('ViewItineraryRT')->searchDatesOfDeparture1RT(
        cityOfDeparture1 => $MOW->id,
        cityOfArrival1   => $BCN->id,
        cityOfDeparture2 => $BCN->id,
        cityOfArrival2   => $MOW->id,
    );

    is($iterator->count, 1, 'got date of departure');
    my $date = $iterator->next();
    is($date->get_column('dateOfDeparture'), $dates[0]->ymd, 'got date of departure');

    #return date
    {
        my $iterator = $schema->resultset('ViewItineraryRT')->searchDatesOfDeparture2RT(
            cityOfDeparture1 => $MOW->id,
            cityOfArrival1   => $BCN->id,
            cityOfDeparture2 => $BCN->id,
            cityOfArrival2   => $MOW->id,
            dateOfDeparture1 => $date->get_column('dateOfDeparture')
        );

        is($iterator->count, 2, 'got dates of return');
        my $date1 = $iterator->next();
        is($date1->get_column('dateOfDeparture'), $dates[1]->ymd, 'got date of return');
        my $date2 = $iterator->next();
        is($date2->get_column('dateOfDeparture'), $dates[2]->ymd, 'got date of return');
    }
}
