use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema( no_populate => 1 );

#first insert
{
    my $article = ClubSpain::Design::Article->new(
        parent_id   => 0,
        weight      => 10,
        is_published => 1,
        header      => 'header',
        body        => 'body'
    );

    my $result;

    eval {
        $result = $article->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Article');
    is($result->parent_id, 0, 'got parent id');
    is($result->is_published, 1, 'got is_published');
    is($result->weight, 0, 'got weight');
    is($result->header, 'header', 'got header');
    is($result->body, 'body', 'got body');
}

#second addition
{
    my $article = ClubSpain::Design::Article->new(
        parent_id   => 0,
        weight      => 100,
        is_published => 0,
        header      => 'header2',
        body        => 'body2'
    );

    my $result;

    eval {
        $result = $article->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Article');
    is($result->parent_id, 0, 'got parent id');
    is($result->is_published, 0, 'got is_published');
    is($result->weight, 1, 'got weight');
    is($result->header, 'header2', 'got header');
    is($result->body, 'body2', 'got body');
}
