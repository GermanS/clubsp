use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

use lib qw(t/lib);
use ClubSpain::Test;
ClubSpain::Test->init_schema( no_populate => 1 );

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
is($result->weight, 10, 'got weight');
is($result->header, 'header', 'got header');
is($result->body, 'body', 'got body');
