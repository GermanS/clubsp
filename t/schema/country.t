use Test::More tests => 1;

use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

my $iterator = $schema->resultset('Country')
                      ->searchCountriesOfDeparture();

is($iterator->count, 2, 'got 2 countries');
