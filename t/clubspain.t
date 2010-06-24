use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain');
is(ClubSpain->VERSION, '0.01', 'check version');
