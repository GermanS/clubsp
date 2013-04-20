use Test::More tests => 10;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Import::Duration' );

my $object = ClubSpain::XML::VipService::Import::Duration -> new(
    origin      => 'MOW',
    destination => 'BCN',
	start => '2013-03-01',
	end   => '2013-03-10',
    days  => [ qw(2 4 6 7) ],
);

isa_ok ( $object, 'ClubSpain::XML::VipService::Import::Duration' );
isa_ok ( $object -> start, 'DateTime' );
isa_ok ( $object -> end, 'DateTime' );

is $object -> origin, 'MOW'
    => sprintf "got origin: %s", $object -> origin;

is $object -> destination, 'BCN'
    => sprintf "got destination: %s", $object -> destination;

is $object -> start -> ymd(), '2013-03-01'
	=> sprintf "got start date: %s", $object -> start -> ymd();

is $object -> end -> ymd(), '2013-03-10'
	=> sprintf "got end date: %s", $object -> end() -> ymd();

is_deeply $object -> days, [ qw(2 4 6 7) ]
    => sprintf "got days: %s", join ", ", $object -> all_days();

{
    my @expected = (
        { start => '2013-03-02T00:00:00', end => '2013-03-09T00:00:00' },
        { start => '2013-03-02T00:00:00', end => '2013-03-12T00:00:00' },
        { start => '2013-03-02T00:00:00', end => '2013-03-14T00:00:00' },
        { start => '2013-03-02T00:00:00', end => '2013-03-10T00:00:00' },
        { start => '2013-03-02T00:00:00', end => '2013-03-16T00:00:00' },

        { start => '2013-03-03T00:00:00', end => '2013-03-10T00:00:00' },
        { start => '2013-03-03T00:00:00', end => '2013-03-12T00:00:00' },
        { start => '2013-03-03T00:00:00', end => '2013-03-14T00:00:00' },
        { start => '2013-03-03T00:00:00', end => '2013-03-16T00:00:00' },
        { start => '2013-03-03T00:00:00', end => '2013-03-17T00:00:00' },

        { start => '2013-03-05T00:00:00', end => '2013-03-12T00:00:00' },
        { start => '2013-03-05T00:00:00', end => '2013-03-14T00:00:00' },
        { start => '2013-03-05T00:00:00', end => '2013-03-16T00:00:00' },
        { start => '2013-03-05T00:00:00', end => '2013-03-17T00:00:00' },
        { start => '2013-03-05T00:00:00', end => '2013-03-19T00:00:00' },

        { start => '2013-03-07T00:00:00', end => '2013-03-14T00:00:00' },
        { start => '2013-03-07T00:00:00', end => '2013-03-19T00:00:00' },
        { start => '2013-03-07T00:00:00', end => '2013-03-16T00:00:00' },
        { start => '2013-03-07T00:00:00', end => '2013-03-17T00:00:00' },
        { start => '2013-03-07T00:00:00', end => '2013-03-21T00:00:00' },

        { start => '2013-03-09T00:00:00', end => '2013-03-16T00:00:00' },
        { start => '2013-03-09T00:00:00', end => '2013-03-19T00:00:00' },
        { start => '2013-03-09T00:00:00', end => '2013-03-21T00:00:00' },
        { start => '2013-03-09T00:00:00', end => '2013-03-17T00:00:00' },
        { start => '2013-03-09T00:00:00', end => '2013-03-23T00:00:00' },

        { start => '2013-03-10T00:00:00', end => '2013-03-17T00:00:00' },
        { start => '2013-03-10T00:00:00', end => '2013-03-19T00:00:00' },
        { start => '2013-03-10T00:00:00', end => '2013-03-21T00:00:00' },
        { start => '2013-03-10T00:00:00', end => '2013-03-23T00:00:00' },
        { start => '2013-03-10T00:00:00', end => '2013-03-24T00:00:00' },
    );

    my @got = $object -> dates();
    is_deeply \@got, \@expected
        => 'compare dates() output';
}
