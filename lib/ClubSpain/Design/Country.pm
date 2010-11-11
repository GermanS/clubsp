package ClubSpain::Design::Country;

use Moose;
use namespace::autoclean;

use parent qw(ClubSpain::Design::Base);

use ClubSpain::Common qw(minify);
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

    $self->schema->resultset('Country')->create({
        name        => $self->name,
        alpha2      => $self->alpha2,
        alpha3      => $self->alpha3,
        numerics    => $self->numerics,
    });
}

sub update {
    my $self = shift;

    return $self->fetch_by_id()->update({
        name        => $self->name,
        alpha2      => $self->alpha2,
        alpha3      => $self->alpha3,
        numerics    => $self->numerics,
    });
}

sub delete {
    my ($class, $id) = @_;

    return $class->fetch_by_id($id)->delete();
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        unless $id;

    my $object = $self->schema
                      ->resultset('Country')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Country: $id!")
        unless $object;

    return $object;
}

__PACKAGE__->meta->make_immutable();

1;


