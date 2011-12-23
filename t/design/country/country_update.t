use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Country');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

my $country = ClubSpain::Model::Country->new(
    id       => 1,
    name     => 'Soviet union',
    alpha2   => 'su',
    alpha3   => 'suu',
    numerics => '123',
    is_published => 1,
);

my $result = $country->update();

isa_ok($result, 'ClubSpain::Schema::Result::Country');
is($result->id, 1, 'got id');
is($result->name, 'Soviet union', 'got name');
is($result->alpha2, 'su', 'got alpha2');
is($result->alpha3, 'suu', 'got alpha3');
is($result->numerics, 123, 'got numerics');
is($result->is_published, 1, 'got is_published');
