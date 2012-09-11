use Test::More tests => 23;
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
        INN     => 7702581366,
        OKPO    => 79011171,
        OKVED   => 4234567890,
        is_NDS  => 1,
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

    is $result->zipcode, 123456
        => 'got zipcode';
    is $result->street, 'calle de colomn 4'
        => 'got street';
    is $result->name, 'origin name'
        => 'origin name';
    is $result->nick, 'brand name'
        => 'brand name';
    is $result->website, 'somewhere.com'
        => 'got website';
    is $result->INN, 7702581366
        => 'got INN';
    is $result->OKPO, 79011171
        => 'got OKPO';
    is $result->OKVED, 4234567890
        => 'got OKVED';
    is $result->is_NDS, 1
        => 'got is_NDS';
    is $result->is_published, 1
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
        INN     => 673002363905,
        OKPO    => 7901117001,
        OKVED   => 1234,
        is_NDS  => 0,
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

    is $result->zipcode, 654321
        => 'got zipcode';
    is $result->street, 'calle de colomn 6'
        => 'got street';
    is $result->name, 'new name'
        => 'origin name';
    is $result->nick, 'new nick'
        => 'brand name';
    is $result->website, 'somewhere.net'
        => 'got website';
    is $result->INN, 673002363905
        => 'got INN';
    is $result->OKPO, 7901117001
        => 'got OKPO';
    is $result->OKVED, 1234
        => 'got OKVED';
    is $result->is_NDS, 0
        => 'got is_NDS';
    is $result->is_published, 0
        => 'got is_published';
}
