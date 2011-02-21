use Test::More tests => 6;

use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::Country');

#searchCountriesOfDeparture()
{
    my $iterator =
        ClubSpain::Model::Country->searchCountriesOfDeparture();


    is($iterator->count, 2, 'got 2 countries');

    my $russia = $iterator->next();
    is($russia->id, 1, 'got id');
    is($russia->name, 'Russia', 'got name');

    my $spain = $iterator->next();
    is($spain->id, 2, 'got id');
    is($spain->name, 'Spain', 'got name');
}
