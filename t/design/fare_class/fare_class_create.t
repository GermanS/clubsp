use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Model::FareClass');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $fareclass = ClubSpain::Model::FareClass->new(
        code    => 'x',
        name    => 'name',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $fareclass->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::FareClass');
    is($result->code, 'x', 'got code');
    is($result->name, 'name', 'got name');
    is($result->is_published, 1, 'got is_published');
}

#second addition
{
    my $fareclass = ClubSpain::Model::FareClass->new(
        code    => 'J',
        name    => 'yyyy',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $fareclass->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::FareClass');
    is($result->code, 'J', 'got code');
    is($result->name, 'yyyy', 'got name');
    is($result->is_published, 1, 'got is_published');
}
