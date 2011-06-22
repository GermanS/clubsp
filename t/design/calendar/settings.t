use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Model::Calendar::Settings');

my $settings = ClubSpain::Model::Calendar::Settings->new();
isa_ok($settings, 'ClubSpain::Model::Calendar::Settings');
is($settings->months, 7, 'got months');
is($settings->locale, 'ru_RU', 'got locale');
