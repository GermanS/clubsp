package ClubSpain::Model::Company;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Company' });

has 'id'      => ( is => 'rw' );
has 'zipcode' => ( is => 'rw' );
has 'street'  => ( is => 'rw' );
has 'name'    => ( is => 'rw' );
has 'nick'    => ( is => 'rw' );
has 'website' => ( is => 'rw' );
has 'INN'     => ( is => 'rw' );
has 'OKPO'    => ( is => 'rw' );
has 'OKVED'   => ( is => 'rw' );
has 'is_published'
              => ( is => 'rw', required => 1 );

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
        id      => $self->id,
        zipcode => $self->zipcode,
        street  => $self->street,
        name    => $self->name,
        nick    => $self->nick,
        website => $self->website,
        INN     => $self->INN,
        OKPO    => $self->OKPO,
        OKVED   => $self->OKVED,
        is_published => $self->is_published
    };
}

__PACKAGE__->meta->make_immutable();

1;

