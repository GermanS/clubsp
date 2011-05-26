use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

my $city = ClubSpain::Model::City->new(
    id          => 1,
    country_id  => 2,
    iata        => 'MAL',
    name        => 'New City name',
    is_published=> 0,
);

my $result = $city->update();

isa_ok($result, 'ClubSpain::Schema::Result::City');
is($result->id, 1, 'got id');
is($result->country_id, 2, 'got country id');
is($result->iata, 'MAL', 'got iata code');
is($result->name, 'New City name', 'got name');
is($result->is_published, 0, 'got is_published');
