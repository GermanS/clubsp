use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain');
is(ClubSpain->VERSION, '0.05', 'check version');
