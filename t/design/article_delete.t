use Test::More tests => 9;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema( no_populate => 1 );

my $article = ClubSpain::Design::Article->new(
    parent_id       => 0,
    weight          => 100,
    is_published    => 0,
    header          => 'header',
    subheader       => 'subheader',
    body            => 'body'
);

my $object = $article->create();

isa_ok($object, 'ClubSpain::Schema::Article');
is($object->parent_id, 0, 'got parent id');
is($object->weight, 0, 'got weight');
is($object->is_published, 0, 'got is published');
is($object->header, 'header', 'got header');
is($object->subheader, 'subheader', 'got subheader');
is($object->body, 'body', 'got body');


ClubSpain::Design::Article->delete($object->id);


my $rs = $schema->resultset('Article')->search({});
is($rs->count, 0, 'no objects left');
