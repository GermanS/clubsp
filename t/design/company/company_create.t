use Test::More tests => 21;
use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $company = ClubSpain::Model::Company->new(
        zipcode => 123456,
        street  => 'calle de colomn 4',
        name    => 'origin name',
        nick    => 'brand name',
        website => 'somewhere.com',
        INN     => 1234567890123,
        OKPO    => 3234567890,
        OKVED   => 4234567890,
        is_published => 1
    );

    my $result;

    eval {
        $result = $company->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    is $company->zipcode, 123456
        => 'got zipcode';
    is $company->street, 'calle de colomn 4'
        => 'got street';
    is $company->name, 'origin name'
        => 'origin name';
    is $company->nick, 'brand name'
        => 'brand name';
    is $company->website, 'somewhere.com'
        => 'got website';
    is $company->INN, 1234567890123
        => 'got INN';
    is $company->OKPO, 3234567890
        => 'got OKPO';
    is $company->OKVED, 4234567890
        => 'got OKVED';
    is $company->is_published, 1
        => 'got is_published';
}

#second addition
{
    my $company = ClubSpain::Model::Company->new(
        zipcode => 654321,
        street  => 'calle de colomn 6',
        name    => 'new name',
        nick    => 'new nick',
        website => 'somewhere.net',
        INN     => 1234567890,
        OKPO    => 987654321,
        OKVED   => 1234,
        is_published => 0
    );

    my $result;

    eval {
        $result = $company->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    is $company->zipcode, 654321
        => 'got zipcode';
    is $company->street, 'calle de colomn 6'
        => 'got street';
    is $company->name, 'new name'
        => 'origin name';
    is $company->nick, 'new nick'
        => 'brand name';
    is $company->website, 'somewhere.net'
        => 'got website';
    is $company->INN, 1234567890
        => 'got INN';
    is $company->OKPO, 987654321
        => 'got OKPO';
    is $company->OKVED, 1234
        => 'got OKVED';
    is $company->is_published, 0
        => 'got is_published';
}
