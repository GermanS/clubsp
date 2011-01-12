package ClubSpain::Design::Manufacturer;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'   => ( is => 'ro' );
has 'code' => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'name' => ( is => 'ro', required => 1, isa => 'StringLength2to255' );

sub create {
    my $self = shift;

    $self->schema->resultset('Manufacturer')->create({
        code    => $self->code,
        name    => $self->name,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('Manufacturer')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Manufacturer: $id!")
        unless $object;

    return $object;
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        code   => $self->code,
        name   => $self->name,
    });
}

1;
