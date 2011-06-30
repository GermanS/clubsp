use Test::More tests => 8;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

my $MOW = $schema->resultset('City')->search({ id => 1 })->single;
sub is_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id');
    is($mow->iata, $MOW->iata, 'got iata code');
    is($mow->name, $MOW->name, 'got Moscow');
}

my $BCN = $schema->resultset('City')->search({ id => 2 })->single;
sub is_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id');
    is($bcn->iata, $BCN->iata, 'got iata code');
    is($bcn->name, $BCN->name, 'got Barcelona');
}

{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDeparture1InRTItinerary();

    is($iterator->count, 2, 'got two cities of departure');
    &is_MOW($iterator->next);
    &is_BCN($iterator->next);
}

#set russia.is_published to 0

{

    my $ru = $schema->resultset('Country')->search({ id => 1 });
    $ru->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDeparture1InRTItinerary();
    is($iterator->count, 0, 'got nothing');

    $ru->update({ is_published => 1 });
}


