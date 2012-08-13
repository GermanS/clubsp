use Test::More tests => 15;
use strict;
use warnings;

use_ok('ClubSpain::Model::Employee');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $employee = ClubSpain::Model::Employee->new(
        name    => 'Petr',
        surname => 'Petrov',
        email   => 'info@aviabroker.com',
        password  => 'passwd',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $employee->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Employee');
    is($employee->name, 'Petr', 'got name');
    is($employee->surname, 'Petrov', 'got surname');
    is($employee->email, 'info@aviabroker.com', 'got email');
    is($employee->password, 'passwd', 'got passwd');
    is($employee->is_published, 1, 'got is published');
}

#second addition
{
    my $employee = ClubSpain::Model::Employee->new(
        name    => 'Ivan',
        surname => 'Ivanov',
        email   => 'alc@aviabroker.com',
        password  => 'passwd',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $employee->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Employee');
    is($employee->name, 'Ivan', 'got name');
    is($employee->surname, 'Ivanov', 'got surname');
    is($employee->email, 'alc@aviabroker.com', 'got email');
    is($employee->password, 'passwd', 'got passwd');
    is($employee->is_published, 1, 'got is published');
}
