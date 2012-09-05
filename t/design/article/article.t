use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Article');

my $article = ClubSpain::Model::Article->new(
    parent_id       => 0,
    weight          => 1,
    is_published    => 1,
    header          => 'header',
    subheader       => 'subheader',
    body            => 'body',
);


isa_ok($article, 'ClubSpain::Model::Article');
is $article->get_parent_id, 0
    => 'got parent_id';
is $article->get_weight, 1
    => 'got weight';
is $article->get_is_published, 1
    => 'got header';
is $article->get_header, 'header'
    => 'got header';
is $article->get_subheader, 'subheader'
    => 'got subheader';
is $article->get_body, 'body'
    => 'got body';
