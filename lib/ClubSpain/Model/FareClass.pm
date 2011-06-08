package ClubSpain::Model::FareClass;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'FareClass' });

has 'id'            => ( is => 'ro' );
has 'code'          => ( is => 'ro', required => 1, isa => 'AlphaLength1' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->SUPER::create({
        code         => $self->code,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update({
        code         => $self->code,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

__PACKAGE__->meta->make_immutable;

1;
