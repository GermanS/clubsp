use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $city = ClubSpain::Model::City->new(
        country_id   => 1,
        name         => 'new york1',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $city->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::City');
    is($result->country_id, 1, 'got country_id');
    is($result->name, 'new york1', 'got name');
    is($result->is_published, 1, 'got is_published');
}

#second addition
{
    my $city = ClubSpain::Model::City->new(
        country_id   => 2,
        name         => 'new york2',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $city->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::City');
    is($result->country_id, 2, 'got country_id');
    is($result->name, 'new york2', 'got name');
    is($result->is_published, 1, 'got is_published');
}
