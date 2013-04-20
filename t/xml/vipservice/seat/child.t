use Test::More tests => 11;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Seat::Child' );

{
    my $child = ClubSpain::XML::VipService::Seat::Child -> new();
    isa_ok( $child, 'ClubSpain::XML::VipService::Seat::Child' );

    is $child -> count(), 0
        => 'got default value: 0';

    isnt $child -> is_adult(), 1
        => 'this is not adult';

    is $child -> is_child(), 1
        => 'this is child';

    isnt $child -> is_infant(), 1
        => 'this is not infant';
}

{
    my $child = ClubSpain::XML::VipService::Seat::Child -> new( count => 2 );
    isa_ok( $child, 'ClubSpain::XML::VipService::Seat::Child' );

    is $child -> count(), 2
        => 'got right number of children: 2';

    isnt $child -> is_adult(), 1
        => 'this is adult';

    is $child -> is_child(), 1
        => 'this is child';

    isnt $child -> is_infant(), 1
        => 'this is not infant';
}