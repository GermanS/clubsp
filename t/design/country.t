use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

#no exceptions
{
    my $country;
    eval {
        $country = ClubSpain::Design::Country->new(
            name => 'Russia',
            alpha2 => 'ru',
            alpha3 => 'rus',
            numerics => 7
        );

        pass('no exception thrown');
    };

    if ($@) {
        use Data::Dumper;
        diag Dumper($@);
        fail('caught exception');
    }

    isa_ok($country, 'ClubSpain::Design::Country');
    is($country->name, 'Russia', 'got name');
    is($country->alpha2, 'ru', 'got aplha2');
    is($country->alpha3, 'rus', 'got aplha3');
    is($country->numerics, 7, 'Got numerics');
    is($country->id, undef, 'id not set');
}

#name with spaces
{
    my $country;
    eval {
        $country = ClubSpain::Design::Country->new(
            name => '   Russia    ',
            alpha2 => 'ru',
            alpha3 => 'rus',
            numerics => 7
        );

        pass('no exception thrown');
    };

    if ($@) {
        use Data::Dumper;
        diag Dumper($@);
        fail('caught exception');
    }

    isa_ok($country, 'ClubSpain::Design::Country');
    is($country->name, 'Russia', 'got name');
    is($country->alpha2, 'ru', 'got aplha2');
    is($country->alpha3, 'rus', 'got aplha3');
    is($country->numerics, 7, 'Got numerics');
    is($country->id, undef, 'id not set');
}
