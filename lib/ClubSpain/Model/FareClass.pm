package ClubSpain::Model::FareClass;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'FareClass' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'code' => (
    is      => 'rw',
    isa     => 'AlphaLength1',
    reader  => 'get_code',
    writer  => 'set_code',
);
has 'name' => (
    is      => 'rw',
    reader  => 'get_name',
    writer  => 'set_name',
    isa     => 'StringLength2to255'
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::FareClass';

sub validate_name {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}
sub validate_code {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('code')->type_constraint->validate($value);
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
        code         => $self->get_code,
        name         => $self->get_name,
        is_published => $self->get_is_published,
    };
}

__PACKAGE__->meta->make_immutable;

1;
