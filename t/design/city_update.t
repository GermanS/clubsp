use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Design::City');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

my $city = ClubSpain::Design::City->new(
    id          => 1,
    country_id  => 2,
    name        => 'New City name',
    is_published=> 0,
);

my $result = $city->update();

isa_ok($result, 'ClubSpain::Schema::City');
is($result->id, 1, 'got id');
is($result->country_id, 2, 'got country id');
is($result->name, 'New City name', 'got name');
is($result->is_published, 0, 'got is_published');
