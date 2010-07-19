use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::Province');
use_ok('ClubSpain::XML::Terramar::Response::Province');

my $xml = read_file('t/var/terramar/response_province.xml');
my $result = ClubSpain::XML::Terramar::Response::Province->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = (
        { provincia => "COSTA DORADA" },
        { provincia => "TARRAGONA" },
        { provincia => "SALOU" },
        { provincia => "SALOU AREA / COSTA DAURADA" },
    );

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::Province($_)
        foreach (@expect);

    return \@objects;
}
