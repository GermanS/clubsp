use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::Design::FareClass');

my $class = ClubSpain::Design::FareClass->new(
    code        => 'B',
    name        => 'Full fare economy class',
    is_published => 1,
);


isa_ok($class, 'ClubSpain::Design::FareClass');
is($class->code, 'B', 'got code');
is($class->name, 'Full fare economy class', 'got name');
is($class->is_published, 1, 'got is published');
