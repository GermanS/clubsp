use Test::More tests => 11;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Seat::Adult' );

{
    my $adult = ClubSpain::XML::VipService::Seat::Adult -> new();
    isa_ok( $adult, 'ClubSpain::XML::VipService::Seat::Adult' );

    is $adult -> count(), 0
        => 'got default value: 0';

    is $adult -> is_adult(), 1
        => 'this is adult';

    isnt $adult -> is_child(), 1
        => 'this is not child';

    isnt $adult -> is_infant(), 1
        => 'this is not infant';
}

{
    my $adult = ClubSpain::XML::VipService::Seat::Adult -> new( count => 2 );
    isa_ok( $adult, 'ClubSpain::XML::VipService::Seat::Adult' );

    is $adult -> count(), 2
        => 'got right number of adults: 2';

    is $adult -> is_adult(), 1
        => 'this is adult';

    isnt $adult -> is_child(), 1
        => 'this is not child';

    isnt $adult -> is_infant(), 1
        => 'this is not infant';
}