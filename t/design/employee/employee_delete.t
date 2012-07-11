use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Employee');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('Employee')->search({})->count;

my $employee = ClubSpain::Model::Employee->new(
    name    => 'Petr',
    surname => 'Petrov',
    email   => 'info@aviabroker.com',
    passwd  => 'passwd',
    is_published => 1,
);

my $object = $employee->create();

isa_ok($object, 'ClubSpain::Schema::Result::Employee');
is($object->name, 'Petr', 'got name');
is($object->surname, 'Petrov', 'got surname');
is($object->email, 'info@aviabroker.com', 'got email');
is($object->passwd,      'passwd', 'got is published');
is($object->is_published, 1, 'got is_published');


ClubSpain::Model::Employee->delete($object->id);

my $rs = $schema->resultset('Employee')->search({});
is($rs->count, $count, 'no objects left');
