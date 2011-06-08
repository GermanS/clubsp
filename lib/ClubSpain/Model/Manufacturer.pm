package ClubSpain::Model::Manufacturer;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Manufacturer' });

has 'id'   => ( is => 'ro' );
has 'code' => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'name' => ( is => 'ro', required => 1, isa => 'StringLength2to255' );

sub create {
    my $self = shift;

    $self->SUPER::create({
        code    => $self->code,
        name    => $self->name,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    return $self->SUPER::update({
        code   => $self->code,
        name   => $self->name,
    });
}

__PACKAGE__->meta->make_immutable;

1;
