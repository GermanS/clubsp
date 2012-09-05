use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $city = ClubSpain::Model::City->new(
        country_id   => 1,
        iata         => 'NYC',
        name_en      => 'new york1',
        name_ru      => 'test',
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

    isa_ok($result, 'ClubSpain::Schema::Result::City');
    is $result->country_id, 1
        => 'got country_id';
    is $result->iata, 'NYC'
        => 'got iata code';
    is $result->name, 'new york1'
        => 'got name';
    is $result->name_ru, 'test'
        => 'got name ru';
    is $result->is_published, 1
        => 'got is_published';
}

#second addition
{
    my $city = ClubSpain::Model::City->new(
        country_id   => 2,
        iata         => 'NYV',
        name_en      => 'new york2',
        name_ru      => 'test2',
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

    isa_ok($result, 'ClubSpain::Schema::Result::City');
    is $result->country_id, 2
        => 'got country_id';
    is $result->iata, 'NYV'
        => 'got iata code';
    is $result->name, 'new york2'
        => 'got name';
    is $result->name_ru, 'test2'
        => 'got name ru';
    is $result->is_published, 1
        => 'got is_published';
}
