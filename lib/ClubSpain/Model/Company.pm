package ClubSpain::Model::Company;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Company' });

has 'id'    => ( is => 'ro' );
has 'name'  => ( is => 'ro' );
has 'nick'  => ( is => 'ro' );
has 'INN'   => ( is => 'ro' );
has 'OGRN'  => ( is => 'ro' );
has 'KPP'   => ( is => 'ro' );
has 'OKPO'  => ( is => 'ro' );
has 'OKVED' => ( is => 'ro' );
has 'OKATO' => ( is => 'ro' );
has 'OKTMO' => ( is => 'ro' );
has 'OKOGU' => ( is => 'ro' );
has 'OKFS'  => ( is => 'ro' );
has 'OKPF'  => ( is => 'ro' );

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update($self->params() );
}

sub params {
    my $self = shift;

    return {
        name  => $self->name,
        nick  => $self->nick,
        INN   => $self->INN,
        OGRN  => $self->OGRN,
        KPP   => $self->KPP,
        OKPO  => $self->OKPO,
        OKVED => $self->OKVED,
        OKATO => $self->OKATO,
        OKTMO => $self->OKTMO,
        OKOGU => $self->OKOGU,
        OKFS  => $self->OKFS,
        OKPF  => $self->OKPF,
    };
}

__PACKAGE__->meta->make_immutable();

1;

