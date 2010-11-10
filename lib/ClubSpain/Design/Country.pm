package ClubSpain::Design::Country;

use Moose;
use namespace::autoclean;

use parent qw(ClubSpain::Design::Base);

use ClubSpain::Types;
use ClubSpain::Common qw(minify);

has 'id'       => ( is => 'ro' );
has 'name'     => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'alpha2'   => ( is => 'ro', required => 1, isa => 'AlphaLength2' );
has 'alpha3'   => ( is => 'ro', required => 1, isa => 'AlphaLength3' );
has 'numerics' => ( is => 'ro', required => 1, isa => 'NaturalLessThan1000' );

sub BUILDARGS {
    my ($class,  %param) = @_;

    $param{'name'} = minify($param{'name'});

    return \%param;
}

__PACKAGE__->meta->make_immutable();

1;


