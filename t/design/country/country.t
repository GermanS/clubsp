use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Model::Country');

#no exceptions
{
    my $country;
    eval {
        $country = ClubSpain::Model::Country->new(
            name    => 'Russia',
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
    is $country->get_name, 'Russia'
        => 'got name';
    is $country->get_alpha2, 'ru'
        => 'got aplha2';
    is $country->get_alpha3, 'rus'
        => 'got aplha3';
    is $country->get_numerics, 7
        => 'Got numerics';
    is $country->get_id, undef
        => 'id not set';
    is $country->get_is_published, 1
        => 'got is_published';
}

#name with spaces
{
    my $country;
    eval {
        $country = ClubSpain::Model::Country->new(
            name    => 'Spain',
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
    is $country->get_name, 'Spain'
        => 'got name';
    is $country->get_alpha2, 'ru'
        => 'got aplha2';
    is $country->get_alpha3, 'rus'
        => 'got aplha3';
    is $country->get_numerics, 7
        => 'Got numerics';
    is $country->get_id, undef
        => 'id not set';
    is $country->get_is_published, 1
        => 'got is_published';
}
