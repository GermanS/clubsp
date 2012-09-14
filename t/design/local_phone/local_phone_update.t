use Test::More tests => 5;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::LocalPhone');
#add account to database
my $init;
{
    my $phone = ClubSpain::Model::LocalPhone->new(
        office_id   => 1,
        number      => 4455566777,
        is_published => 0,
    );
    $init = $phone->create();
}

my $params = {
    id          => $init->id,
    office_id   => 1,
    number      => 8888999900,
    is_published => 1,
};

my $phone = ClubSpain::Model::LocalPhone->new( $params );
my $result = $phone->update();

isa_ok($result, 'ClubSpain::Schema::Result::LocalPhone');
is $result->office_id, $params->{'office_id'}
    => 'got office id';
is $result->number, $params->{'number'}
    => 'got [hone number';
is $result->is_published, $params->{'is_published'}
    => 'got is published flag';
