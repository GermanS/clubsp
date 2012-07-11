use Test::More tests => 8;
use strict;
use warnings;
use lib qw(t/lib);

use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Employee');

my $employee = ClubSpain::Model::Employee->new(
    id          => 1,
    name        => 'german',
    surname     => 'semenkov',
    email       => 'german.semenkov@gmail.com',
    passwd      => '123',
    is_published=> 0,
);

my $result = $employee->update();

isa_ok($result, 'ClubSpain::Schema::Result::Employee');
is($result->id, 1, 'got id');
is($result->name, 'german', 'got name');
is($result->surname, 'semenkov', 'got surname');
is($result->email, 'german.semenkov@gmail.com', 'got email');
is($result->passwd, '123', 'got pass');
is($result->is_published, 0, 'got is_published');
