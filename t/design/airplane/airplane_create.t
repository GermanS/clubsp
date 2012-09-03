use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airplane');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();

#first insert
{
    my $airplane = ClubSpain::Model::Airplane->new(
        manufacturer_id => 1,
        iata    => 'xxx',
        icao    => 'xxxx',
        airplane => 'xxx xxxx',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $airplane->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Airplane');
    is($result->manufacturer_id, 1, 'got manufacturer id');
    is($result->iata, 'xxx', 'got iata code');
    is($result->icao, 'xxxx', 'got icao code');
    is($result->name, 'xxx xxxx', 'got name');
    is($result->is_published, 1, 'got is_published');
}

#second addition
{
    my $airplane = ClubSpain::Model::Airplane->new(
        manufacturer_id => 1,
        iata     => 'yyy',
        icao     => 'yyyy',
        airplane => 'yyy yyyy',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $airplane->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Airplane');
    is($result->manufacturer_id, 1, 'got manufacturer id');
    is($result->iata, 'yyy', 'got iata code');
    is($result->icao, 'yyyy', 'got icao code');
    is($result->name, 'yyy yyyy', 'got name');
    is($result->is_published, 1, 'got is_published');
}
