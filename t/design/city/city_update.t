use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

my $city = ClubSpain::Model::City->new(
    id          => 1,
    country_id  => 2,
    iata        => 'MAL',
    name_en     => 'New City name',
    name_ru     => 'New name',
    is_published=> 0,
);

my $result = $city->update();

isa_ok($result, 'ClubSpain::Schema::Result::City');
is $result->id, 1
    => 'got id';
is $result->country_id, 2
    => 'got country id';
is $result->iata, 'MAL'
    => 'got iata code';
is $result->name, 'New City name'
    => 'got name';
is $result->name_ru, 'New name'
    => 'got name ru';
is $result->is_published, 0
    => 'got is_published';
