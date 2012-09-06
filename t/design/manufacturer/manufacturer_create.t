use Test::More tests => 9;

use strict;
use warnings;

use_ok('ClubSpain::Model::Manufacturer');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $producer = ClubSpain::Model::Manufacturer->new(
        code    => 'xxx',
        name    => 'xxx xxxx',
    );

    my $result;

    eval {
        $result = $producer->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Manufacturer');
    is $result->code, 'xxx'
        => 'got code';
    is $result->name, 'xxx xxxx'
        => 'got name';
}

#second addition
{
    my $producer = ClubSpain::Model::Manufacturer->new(
        code    => 'yyy',
        name    => 'yyy yyyy',
    );

    my $result;

    eval {
        $result = $producer->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Manufacturer');
    is $result->code, 'yyy'
        => 'got icao code';
    is $result->name, 'yyy yyyy'
        => 'got name';
}
