use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::Occupation');
use_ok('ClubSpain::XML::Terramar::Response::Occupation');

my $xml = read_file('t/var/terramar/response_occupation.xml');
my $result = ClubSpain::XML::Terramar::Response::Occupation->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
        adultos_max => 15,
        adultos_min => 0,
        ninos_max   => 10,
        pax_max     => 15,
        edad_nino_max =>99,
    });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::Occupation($_)
        foreach (@expect);

    return \@objects;
}
