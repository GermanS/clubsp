use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

my $article = ClubSpain::Design::Article->new(
    id          => 1,
    parent_id   => 0,
    weight      => 10,
    is_published => 1,
    header      => 'new header',
    body        => 'new body'
);

my $result = $article->update();

isa_ok($result, 'ClubSpain::Schema::Article');
is($result->id, 1, 'got id');
is($result->parent_id, 0, 'got parent id');
is($result->weight, 10, 'got weight');
is($result->is_published, 1, 'got is_published');
is($result->header, 'new header', 'got header');
is($result->body, 'new body', 'got body');
