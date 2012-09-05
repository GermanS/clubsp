package ClubSpain::Model::Manufacturer;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);

use ClubSpain::Types;
    with 'ClubSpain::Model::ManufacturerRole';

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Manufacturer' });

has 'id'   => ( is => 'rw' );
has 'code' => ( is => 'rw', required => 0, isa => 'StringLength2to255' );
has 'name' => ( is => 'rw', required => 0, isa => 'StringLength2to255' );

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        code   => $self->code,
        name   => $self->name,
    };
}

__PACKAGE__->meta->make_immutable;

1;
