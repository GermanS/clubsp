package ClubSpain::Model::Manufacturer;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Manufacturer' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'code' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_code',
    writer  => 'set_code',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);

with 'ClubSpain::Model::Role::Manufacturer';

sub validate_code {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('code')->type_constraint->validate($value);
}
sub validate_name {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name')->type_constraint->validate($value);
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
        code   => $self->get_code,
        name   => $self->get_name,
    };
}

__PACKAGE__->meta->make_immutable;

1;
