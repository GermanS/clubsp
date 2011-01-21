use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Design::Flight');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $airline = ClubSpain::Design::Flight->new(
        departure_airport_id    => 1,
        destination_airport_id  => 2,
        airline_id              => 1,
        code                    => 8331,
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

    isa_ok($result, 'ClubSpain::Schema::Flight');
    is($result->departure_airport_id, 1, 'got departure airport');
    is($result->destination_airport_id, 2, 'got destination airport');
    is($result->airline_id, 1, 'got airline');
    is($result->code, 8331, 'got code');
}

#second addition
{
    my $airline = ClubSpain::Design::Flight->new(
        departure_airport_id    => 2,
        destination_airport_id  => 1,
        airline_id              => 1,
        code                    => 8332,
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

    isa_ok($result, 'ClubSpain::Schema::Flight');
    is($result->departure_airport_id, 2, 'got departure airport');
    is($result->destination_airport_id, 1, 'got destination airport');
    is($result->airline_id, 1, 'got airline');
    is($result->code, 8332, 'got code');
}
