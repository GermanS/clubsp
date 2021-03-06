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
use ClubSpain::Test::Model::TimeTable;
use ClubSpain::Test::Model::Itinerary;

use ClubSpain::Test::Model::Operator;

use ClubSpain::Test::Model::Company;
use ClubSpain::Test::Model::Office;
use ClubSpain::Test::Model::Employee;

use ClubSpain::Test::Model::BankAccount;
use ClubSpain::Test::Model::LocalPhone;

use ClubSpain::Test::Model::Customer;

use ClubSpain::Test::Model::Article;

Test::Class -> runtests();