use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $fare = ClubSpain::Model::Fare->new(
        fare => 100,
    );

    my $result;

    eval {
        $result = $fare->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Fare');
    is($result->fare, 100, 'got fare');
}

#second addition
{
    my $fare = ClubSpain::Model::Fare->new(
        fare => 1000,
    );

    my $result;

    eval {
        $result = $fare->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Fare');
    is($result->fare, 1000, 'got fare');
}
