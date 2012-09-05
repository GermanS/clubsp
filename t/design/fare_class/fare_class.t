use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::Model::FareClass');

my $class = ClubSpain::Model::FareClass->new(
    code        => 'B',
    name        => 'Full fare economy class',
    is_published => 1,
);

isa_ok($class, 'ClubSpain::Model::FareClass');

is $class->get_code, 'B'
    =>'got code';
is $class->get_name, 'Full fare economy class'
    => 'got name';
is $class->get_is_published, 1
    => 'got is published';
