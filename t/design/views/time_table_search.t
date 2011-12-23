use Test::More tests => 21;
use strict;
use warnings;
use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;

my $MOW = $helper->moscow();
my $BCN = $helper->barcelona();

my @date = ClubSpain::Test->three_saturdays_ahead();

sub request {
    my %params = @_;
    return $schema->resultset('ViewTimeTable')->searchTimetable(%params);
}

sub request2 {
    my %params = @_;
    return ClubSpain::Model::TimeTable->searchTimetable(%params);
}

{
    {
        my $iterator = request(
            cityOfDeparture => $MOW->id,
            cityOfArrival   => $BCN->id,
            dateOfDeparture => $date[0]->ymd
        );

        isa_ok($iterator, 'ClubSpain::Schema::ResultSet::ViewTimeTable');
        is($iterator->count, 1, 'got one row');

        my $row = $iterator->next();
        isa_ok($row, 'ClubSpain::Schema::Result::ViewTimeTable');
        is($row->dateOfDeparture, $date[0]->ymd, 'for date of departure');
        is($row->name, 'NN 331 (DME - BCN)', 'got "name" of timetable');
    }

    {
        my $iterator = request2(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );

        isa_ok($iterator, 'ClubSpain::Schema::ResultSet::ViewTimeTable');
        is($iterator->count, 1, 'got one row');

        my $row = $iterator->next();
        isa_ok($row, 'ClubSpain::Schema::Result::ViewTimeTable');
        is($row->dateOfDeparture, $date[0]->ymd, 'for date of departure');
        is($row->name, 'NN 332 (BCN - DME)', 'got "name" of timetable');
    }
}


#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({id => 2});
    $spain->update({ is_published => 0 });

    {
        my $iterator = request(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $bcn = $schema->resultset('City')->search({ id => 2 });
    $bcn->update({ is_published => 0 });

    {
        my $iterator = request(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    $bcn->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $bcn = $schema->resultset('Airport')->search({ id => 4 });
    $bcn->update({ is_published => 0 });

    {
        my $iterator = request(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    $bcn->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    {
        my $iterator = request(
            cityOfDeparture => $MOW->id,
            cityOfArrival   => $BCN->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(
            cityOfDeparture => $MOW->id,
            cityOfArrival   => $BCN->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    $NN331->update({ is_published => 1 });
}

#set timetable.is_published to 0
{
    my @NN332_BCN_DME = $schema->resultset('TimeTable')->search({ flight_id => 2 });
    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 0 });
    }

    {
        my $iterator = request(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[0]->ymd
        );
        is($iterator->count, 0, 'got nothing');
    }

    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 1 });
    }
}
