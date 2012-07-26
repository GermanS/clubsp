package ClubSpain::Model::Company;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Company' });

has 'id'    => ( is => 'ro' );
has 'name'  => ( is => 'ro', required => 1 );
has 'nick'  => ( is => 'ro' );
has 'INN'   => ( is => 'ro', required => 1 );
has 'OGRN'  => ( is => 'ro', required => 1 );
has 'KPP'   => ( is => 'ro', required => 1 );
has 'OKPO'  => ( is => 'ro', required => 1 );
has 'OKVED' => ( is => 'ro', required => 1 );
has 'OKATO' => ( is => 'ro', required => 1 );
has 'OKTMO' => ( is => 'ro', required => 1 );
has 'OKOGU' => ( is => 'ro', required => 1 );
has 'OKFS'  => ( is => 'ro', required => 1 );
has 'OKPF'  => ( is => 'ro', required => 1 );
has 'is_published'
            => ( is => 'ro', required => 1 );

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
        is_published => $self->is_published
    };
}

__PACKAGE__->meta->make_immutable();

1;

