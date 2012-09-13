use Test::More tests => 8;
use strict;
use warnings;

use_ok('ClubSpain::Model::Office');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('Office')->search({})->count;

my $params = {
    company_id  => 1,
    zipcode     => 123456,
    street      => 'Babushkinskaya 7',
    name        => 'central office',
    is_published => 1,
};
my $office = ClubSpain::Model::Office->new( $params );
my $result = $office->create();

isa_ok($result, 'ClubSpain::Schema::Result::Office');
is $result->company_id, $params->{'company_id'}
    => 'got company id';
is $result->zipcode, $params->{'zipcode'}
    => 'got zipcode';
is $result->street, $params->{'street'}
    => 'got street';
is $result->name, $params->{'name'}
    => 'got name';
is $result->is_published, $params->{'is_published'}
    => 'got is published';

ClubSpain::Model::Office->delete($result->id);


my $rs = $schema->resultset('Office')->search({});
is($rs->count, $count, 'no objects left');
