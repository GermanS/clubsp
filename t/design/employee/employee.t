use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Employee');

my $employee = ClubSpain::Model::Employee->new(
    first_name  => 'Petr',
    surname     => 'Petrov',
    email       => 'info@aviabroker.com',
    password    => 'passwd',
    is_published => 1,
);


isa_ok($employee, 'ClubSpain::Model::Employee');
is($employee->first_name, 'Petr', 'got name');
is($employee->surname, 'Petrov', 'got surname');
is($employee->email, 'info@aviabroker.com', 'got email');
is($employee->password, 'passwd', 'got passwd');
is($employee->is_published, 1, 'got is published');
