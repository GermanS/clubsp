package ClubSpain::Design::Flight;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Common qw(minify);

use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'                     => ( is => 'ro' );
has 'departure_airport_id'   => ( is => 'ro', required => 1 );
has 'destination_airport_id' => ( is => 'ro', required => 1 );
has 'airline_id'             => ( is => 'ro', required => 1 );
has 'code'                   => ( is => 'ro', required => 1,  isa => 'NaturalLessThan10000' );

sub create {
    my $self = shift;

    $self->schema->resultset('Flight')->create({
        departure_airport_id    => $self->departure_airport_id,
        destination_airport_id  => $self->destination_airport_id,
        airline_id              => $self->airline_id,
        code                    => $self->code,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('Flight')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Flight: $id!")
        unless $object;

    return $object;
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        departure_airport_id    => $self->departure_airport_id,
        destination_airport_id  => $self->destination_airport_id,
        airline_id              => $self->airline_id,
        code                    => $self->code,
    });
}

1;
