use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

my $article = ClubSpain::Design::Article->new(
    parent_id       => 0,
    weight          => 1,
    is_published    => 1,
    header          => 'header',
    subheader       => 'subheader',
    body            => 'body',
);


isa_ok($article, 'ClubSpain::Design::Article');
is($article->parent_id, 0, 'got parent_id');
is($article->weight, 1, 'got weight');
is($article->is_published, 1, 'got header');
is($article->header, 'header', 'got header');
is($article->subheader, 'subheader', 'got subheader');
is($article->body, 'body', 'got body');
