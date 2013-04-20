use Test::More tests => 11;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Seat::Infant' );

{
    my $infant = ClubSpain::XML::VipService::Seat::Infant -> new();
    isa_ok( $infant, 'ClubSpain::XML::VipService::Seat::Infant' );

    is $infant -> count(), 0
        => 'got default value: 0';

    isnt $infant -> is_adult(), 1
        => 'this is not adult';

    isnt $infant -> is_child(), 1
        => 'this is not child';

    is $infant -> is_infant(), 1
        => 'this is infant';
}

{
    my $infant = ClubSpain::XML::VipService::Seat::Infant -> new( count => 2 );
    isa_ok( $infant, 'ClubSpain::XML::VipService::Seat::Infant' );

    is $infant -> count(), 2
        => 'got right number of infants: 2';

    isnt $infant -> is_adult(), 1
        => 'this is not adult';

    isnt $infant -> is_child(), 1
        => 'this is not child';

    is $infant -> is_infant(), 1
        => 'this is infant';
}