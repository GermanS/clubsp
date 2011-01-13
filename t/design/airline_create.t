use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airline');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $airline = ClubSpain::Design::Airline->new(
        iata    => 'xx',
        icao    => 'xxx',
        name    => 'xx xxx',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $airline->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Airline');
    is($result->iata, 'xx', 'got iata code');
    is($result->icao, 'xxx', 'got icao code');
    is($result->name, 'xx xxx', 'got name');
    is($result->is_published, 1, 'got is_published');
}

#second addition
{
    my $airline = ClubSpain::Design::Airline->new(
        iata    => 'yy',
        icao    => 'yyy',
        name    => 'yy yyy',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $airline->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Airline');
    is($result->iata, 'yy', 'got iata code');
    is($result->icao, 'yyy', 'got icao code');
    is($result->name, 'yy yyy', 'got name');
    is($result->is_published, 1, 'got is_published');
}
