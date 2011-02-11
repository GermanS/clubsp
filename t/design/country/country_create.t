use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Country');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

my $country = ClubSpain::Model::Country->new(
    name     => 'USA',
    alpha2   => 'us',
    alpha3   => 'usa',
    numerics => 1,
    is_published => 1,
);

my $result;
eval {
    $result = $country->create();
    pass('no exception thrown');
};


if ($@) {
    fail('caught exception');
    use Data::Dumper;
    diag Dumper($@);
}

isa_ok($result, 'ClubSpain::Schema::Country');
is($result->name, 'USA', 'got name');
is($result->alpha2, 'us', 'got alpha2');
is($result->alpha3, 'usa', 'got alpha3');
is($result->numerics, '1', 'got numerics');
is($result->is_published, 1, 'got is_published');
