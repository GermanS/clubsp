package ClubSpain::Model::Airplane;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airplane' });

has 'id'                => ( is => 'rw' );
has 'manufacturer_id'   => ( is => 'rw', required => 0 );
has 'iata'              => ( is => 'rw', required => 0, isa => 'AlphaNumericLength3' );
has 'icao'              => ( is => 'rw', required => 0, isa => 'AlphaNumericLength4' );
has 'airplane'          => ( is => 'rw', required => 0, isa => 'StringLength2to255' );
has 'is_published'      => ( is => 'rw', required => 0 );

with 'ClubSpain::Model::Role::Airplane';

sub validate_airplane {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('airplane')->type_constraint->validate($value);
}
sub validate_iata {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('iata')->type_constraint->validate($value);
}
sub validate_icao {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('icao')->type_constraint->validate($value);
}



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
        manufacturer_id     => $self->manufacturer_id,
        iata                => $self->iata,
        icao                => $self->icao,
        name                => $self->airplane,
        is_published        => $self->is_published,
    };
}

__PACKAGE__->meta->make_immutable;

=head

http://skalolaskovy.narod.ru/avia/type_of_aircrafts.html

=cut

1;
