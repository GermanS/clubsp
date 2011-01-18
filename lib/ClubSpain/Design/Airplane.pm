package ClubSpain::Design::Airplane;

=head

http://skalolaskovy.narod.ru/avia/type_of_aircrafts.html

=cut

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Common qw(minify);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'                => ( is => 'ro' );
has 'manufacturer_id'   => ( is => 'ro', required => 1 );
has 'iata'              => ( is => 'ro', required => 1, isa => 'AlphaNumericLength3' );
has 'icao'              => ( is => 'ro', required => 1, isa => 'AlphaNumericLength4' );
has 'name'              => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'      => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->schema->resultset('Airplane')->create({
        manufacturer_id     => $self->manufacturer_id,
        iata                => $self->iata,
        icao                => $self->icao,
        name                => $self->name,
        is_published        => $self->is_published,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('Airplane')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Airplane: $id!")
        unless $object;

    return $object;
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        manufacturer_id     => $self->manufacturer_id,
        iata                => $self->iata,
        icao                => $self->icao,
        name                => $self->name,
        is_published        => $self->is_published,
    });
}

1;
