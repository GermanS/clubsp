package ClubSpain::Model::Airplane;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airplane' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'manufacturer_id' => (
    is      => 'rw',
    reader  => 'get_manufacturer_id',
    writer  => 'set_manufacturer_id',
);
has 'iata' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength3',
    reader  => 'get_iata',
    writer  => 'set_iata',
);
has 'icao' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength4',
    reader  => 'get_icao',
    writer  => 'set_icao',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Airplane';

sub validate_manufacturer_id {
}
sub validate_name {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name')->type_constraint->validate($value);
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
        iata            => $self->get_iata,
        icao            => $self->get_icao,
        name            => $self->get_name,
        manufacturer_id => $self->get_manufacturer_id,
        is_published    => $self->get_is_published,
    };
}

__PACKAGE__->meta->make_immutable;

=head

http://skalolaskovy.narod.ru/avia/type_of_aircrafts.html

=cut

1;
