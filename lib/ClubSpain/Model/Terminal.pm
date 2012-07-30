package ClubSpain::Model::Terminal;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
    with 'ClubSpain::Model::TerminalRole';

class_has '+source_name' => ( default => sub  { 'Terminal' });

has 'id'            => ( is => 'rw' );
has 'airport_id'    => ( is => 'rw', required => 0 );
has 'name'          => ( is => 'rw', required => 0, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'rw', required => 0 );

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    return $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        airport_id   => $self->airport_id,
        name         => $self->name,
        is_published => $self->is_published,
    };
}


__PACKAGE__->meta->make_immutable;

1;
