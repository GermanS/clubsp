use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Employee');

my $employee = ClubSpain::Model::Employee->new(
    name    => 'Petr',
    surname => 'Petrov',
    email   => 'info@aviabroker.com',
    password => 'passwd',
    is_published => 1,
);

isa_ok($employee, 'ClubSpain::Model::Employee');
is $employee->get_name, 'Petr'
    => 'got name';
is $employee->get_surname, 'Petrov'
    => 'got surname';
is $employee->get_email, 'info@aviabroker.com'
    => 'got email';
is $employee->get_password, 'passwd'
    => 'got passwd';
is $employee->get_is_published, 1
    => 'got is published';
