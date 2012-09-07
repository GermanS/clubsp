package ClubSpain::Model::Terminal;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Terminal' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'airport_id' => (
    is      => 'rw',
    reader  => 'get_airport_id',
    writer  => 'set_airport_id',
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

with 'ClubSpain::Model::Role::Terminal';

sub validate_airport_id { 1; }
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
    return $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        airport_id   => $self->get_airport_id,
        name         => $self->get_name,
        is_published => $self->get_is_published,
    };
}


__PACKAGE__->meta->make_immutable;

1;
