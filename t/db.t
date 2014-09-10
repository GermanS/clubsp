use strict;
use warnings;

use lib qw(t/lib);

use ClubSpain::Test::Model::Airline;
use ClubSpain::Test::Model::Airplane;
use ClubSpain::Test::Model::Airport;
use ClubSpain::Test::Model::City;
use ClubSpain::Test::Model::Country;
use ClubSpain::Test::Model::FareClass;
use ClubSpain::Test::Model::Flight;
use ClubSpain::Test::Model::Manufacturer;
use ClubSpain::Test::Model::Terminal;

Test::Class -> runtests();