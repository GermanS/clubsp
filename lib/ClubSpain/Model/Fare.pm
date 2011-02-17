package ClubSpain::Model::Fare;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Fare' });

has 'id'            => ( is => 'ro' );
has 'fare'          => ( is => 'ro', required => 1 );

#has 'segments'      => { is => 'ro', required => 1, isa => 'ArreyRef' };

sub create {
    my $self = shift;

    $self->SUPER::create({
        fare  => $self->fare,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update({
        fare  => $self->fare,
    });
}

1;
