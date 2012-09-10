use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('Company')->search({})->count;

my $company = ClubSpain::Model::Company->new(
    zipcode => 129345,
    street  => 'ivana babushkina 16',
    name    => 'aviabroker.com',
    nick    => 'aviabroker.com',
    website => 'somewhere.com',
    INN     => 123456789021,
    OKPO    => 3234567890,
    OKVED   => 4234567890,
    is_NDS  => 1,
    is_published => 1
);

my $object = $company->create();

isa_ok($object, 'ClubSpain::Schema::Result::Company');
is $object->zipcode, 129345
    => 'got zipcode';
is $object->street, 'ivana babushkina 16'
    => 'got street';
is $object->name, 'aviabroker.com'
    => 'got name';
is $object->nick, 'aviabroker.com'
    => 'got nick';
is $object->website, 'somewhere.com'
    => 'got website';
is $object->INN, 123456789021
    => 'got inn';
is $object->OKPO, 3234567890
    => 'got okpo';
is $object->OKVED, 4234567890
    => 'got okved';
is $object->is_NDS, 1
    => 'got is_NDS';
is $object->is_published, 1
    => 'got is_piblished';

ClubSpain::Model::Company->delete($object->id);

my $rs = $schema->resultset('Company')->search({});
is($rs->count, $count, 'no objects left');
