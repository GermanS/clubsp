use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Model::Article');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new(no_populate => 1);

#first insert
{
    my $article = ClubSpain::Model::Article->new(
        parent_id    => 0,
        weight       => 10,
        is_published => 1,
        header       => 'header',
        subheader    => 'subheader',
        body         => 'body'
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

    isa_ok($result, 'ClubSpain::Schema::Result::Article');
    is $result->parent_id, 0
        => 'got parent id';
    is $result->is_published, 1
        => 'got is_published';
    is $result->weight, 0
        => 'got weight';
    is $result->header, 'header'
        => 'got header';
    is $result->subheader, 'subheader'
        => 'got subheader';
    is $result->body, 'body'
        => 'got body';
}

#second addition
{
    my $article = ClubSpain::Model::Article->new(
        parent_id    => 0,
        weight       => 100,
        is_published => 0,
        header       => 'header2',
        subheader    => 'subheader2',
        body         => 'body2'
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

    isa_ok($result, 'ClubSpain::Schema::Result::Article');
    is $result->parent_id, 0
        => 'got parent id';
    is $result->is_published, 0
        => 'got is_published';
    is $result->weight, 1
        => 'got weight';
    is $result->header, 'header2'
        => 'got header';
    is $result->subheader, 'subheader2'
        => 'got subheader';
    is $result->body, 'body2'
        => 'got body';
}
