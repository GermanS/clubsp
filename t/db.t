use strict;
use warnings;

use lib qw(t/lib);

use ClubSpain::Test::Model::Airline;
use ClubSpain::Test::Model::Airplane;
use ClubSpain::Test::Model::Airport;
use ClubSpain::Test::Model::City;

Test::Class -> runtests();