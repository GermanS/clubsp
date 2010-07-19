use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::HotelAvailability');
use_ok('ClubSpain::XML::Terramar::Response::HotelAvailability');

my $xml = read_file('t/var/terramar/response_hotel_availability.xml');
my $result = ClubSpain::XML::Terramar::Response::HotelAvailability->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = (
      { fecha_desde => "2010-07-16", disponibilidad => "1", fecha_hasta=>"2010-09-03" },
      { fecha_desde => "2010-09-04", disponibilidad => "1", fecha_hasta=>"2010-09-17" },
      { fecha_desde => "2010-09-18", disponibilidad => "1", fecha_hasta=>"2010-10-31" });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::HotelAvailability($_)
        foreach (@expect);
      
    return \@objects;    
}
