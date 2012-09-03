use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Model::Country');

#no exceptions
{
    my $country;
    eval {
        $country = ClubSpain::Model::Country->new(
            country => 'Russia',
            alpha2  => 'ru',
            alpha3  => 'rus',
            numerics => 7,
            is_published => 1,
        );

        pass('no exception thrown');
    };

    if ($@) {
        use Data::Dumper;
        diag Dumper($@);
        fail('caught exception');
    }

    isa_ok($country, 'ClubSpain::Model::Country');
    is($country->country, 'Russia', 'got name');
    is($country->alpha2, 'ru', 'got aplha2');
    is($country->alpha3, 'rus', 'got aplha3');
    is($country->numerics, 7, 'Got numerics');
    is($country->id, undef, 'id not set');
    is($country->is_published, 1, 'got is_published');
}

#name with spaces
{
    my $country;
    eval {
        $country = ClubSpain::Model::Country->new(
            country => 'Spain',
            alpha2  => 'ru',
            alpha3  => 'rus',
            numerics => 7,
            is_published => 1,
        );

        pass('no exception thrown');
    };

    if ($@) {
        use Data::Dumper;
        diag Dumper($@);
        fail('caught exception');
    }

    isa_ok($country, 'ClubSpain::Model::Country');
    is($country->country, 'Spain', 'got name');
    is($country->alpha2, 'ru', 'got aplha2');
    is($country->alpha3, 'rus', 'got aplha3');
    is($country->numerics, 7, 'Got numerics');
    is($country->id, undef, 'id not set');
    is($country->is_published, 1, 'got is_published');
}
