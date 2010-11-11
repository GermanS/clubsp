use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

my $country = ClubSpain::Design::Country->new(
    name     => 'USA',
    alpha2   => 'us',
    alpha3   => 'usa',
    numerics => 1
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
