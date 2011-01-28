use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Model::Terminal');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $terminal = ClubSpain::Model::Terminal->new(
        airport_id  => 1,
        name        => 'xxxxx',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $terminal->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Terminal');
    is($result->airport_id, 1, 'got airport');
    is($result->name, 'xxxxx', 'got name');
    is($result->is_published, 1, 'got is_published');
}

#second addition
{
    my $terminal = ClubSpain::Model::Terminal->new(
        airport_id  => 2,
        name        => 'yyyyy',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $terminal->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Terminal');
    is($result->airport_id, 2, 'got airport');
    is($result->name, 'yyyyy', 'got name');
    is($result->is_published, 1, 'got is_published');
}
