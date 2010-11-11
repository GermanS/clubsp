package ClubSpain::Design::Country;

use Moose;
use namespace::autoclean;

use ClubSpain::Common qw(minify);
use ClubSpain::Storage;
use ClubSpain::Types;

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

sub create {
    my $self = shift;

    my $schema = ClubSpain::Storage->instance()->schema();

    $schema->resultset('Country')->create({
        name        => $self->name,
        alpha2      => $self->alpha2,
        alpha3      => $self->alpha3,
        numerics    => $self->numerics,
    });
}

sub update {
}

sub delete {
}

sub retrieve {
}

sub search {
}

__PACKAGE__->meta->make_immutable();

1;

