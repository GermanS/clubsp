use Test::More tests => 11;
use strict;
use warnings;

use_ok('ClubSpain::Model::LocalPhone');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $params = {
        office_id    => 1,
        number       => 1234567890,
        is_published => 1,
    };
    my $phone = ClubSpain::Model::LocalPhone->new( $params );

    my $result;
    eval {
        $result = $phone->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::LocalPhone');
    is $result->office_id, $params->{'office_id'}
        => 'got office id';
    is $result->number, $params->{'number'}
        => 'got phone number';
    is $result->is_published, $params->{'is_published'}
        => 'got is_published';
}

#second addition
{
    my $params = {
        office_id   => 1,
        number      => 8765432190,
        is_published => 1
    };
    my $phone = ClubSpain::Model::LocalPhone->new( $params );

    my $result;
    eval {
        $result = $phone->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::LocalPhone');
    is $result->office_id, $params->{'office_id'}
        => 'got office id';
    is $result->number, $params->{'number'}
        => 'got phone number';
    is $result->is_published, $params->{'is_published'}
        => 'got is_published';
}
