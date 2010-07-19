use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::ProductClassification');
use_ok('ClubSpain::XML::Terramar::Response::ProductClassification');

my $xml = read_file('t/var/terramar/response_product_classification.xml');
my $result = ClubSpain::XML::Terramar::Response::ProductClassification->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
        id_tipo_articulo_superclase => "1",
        nombre => "HOTELS",
        orden =>1,
    },
    {
        id_tipo_articulo_superclase => "4",
        nombre => "BUS ROUND TRIPS",
        orden =>4,
    },
    {
        id_tipo_articulo_superclase => "5",
        nombre => "TRANSFERS",
        orden =>5,
    },
    {
        id_tipo_articulo_superclase => "6",
        nombre => "EXTRA SERVICE",
        orden =>6,
    });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::ProductClassification($_)
        foreach (@expect);

    return \@objects;
}
