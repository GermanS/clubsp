use Test::More tests => 6;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
ClubSpain::Test->init_schema();

use_ok('ClubSpain::Design::Terminal');

my $terminal = ClubSpain::Design::Terminal->new(
    id          => 1,
    airport_id  => 1,
    name        => 'New Terminal name',
    is_published=> 0,
);

my $result = $terminal->update();

isa_ok($result, 'ClubSpain::Schema::Terminal');
is($result->id, 1, 'got id');
is($result->airport_id, 1, 'got icao code');
is($result->name, 'New Terminal name', 'got name');
is($result->is_published, 0, 'got is_published');
