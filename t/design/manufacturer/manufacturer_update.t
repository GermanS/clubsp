use Test::More tests => 5;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Manufacturer');

my $manufacturer = ClubSpain::Model::Manufacturer->new(
    id          => 1,
    code        => 'cccc',
    name        => 'New manufacturer name',
    is_published=> 0,
);

my $result = $manufacturer->update();

isa_ok($result, 'ClubSpain::Schema::Result::Manufacturer');
is($result->id, 1, 'got id');
is($result->code, 'cccc', 'got code');
is($result->name, 'New manufacturer name', 'got name');
