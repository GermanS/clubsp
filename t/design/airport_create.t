use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airport');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $port = ClubSpain::Design::Airport->new(
        city_id => 1,
        iata    => 'xxx',
        icao    => 'xxxx',
        name    => 'xxx xxxx',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $port->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Airport');
    is($result->city_id, 1, 'got city id');
    is($result->iata, 'xxx', 'got iata code');
    is($result->icao, 'xxxx', 'got icao code');
    is($result->name, 'xxx xxxx', 'got name');
    is($result->is_published, 1, 'got is_published');
}

#second addition
{
    my $port = ClubSpain::Design::Airport->new(
        city_id => 1,
        iata    => 'yyy',
        icao    => 'yyyy',
        name    => 'yyy yyyy',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $port->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Airport');
    is($result->city_id, 1, 'got city id');
    is($result->iata, 'yyy', 'got iata code');
    is($result->icao, 'yyyy', 'got icao code');
    is($result->name, 'yyy yyyy', 'got name');
    is($result->is_published, 1, 'got is_published');
}
