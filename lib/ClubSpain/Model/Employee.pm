package ClubSpain::Model::Employee;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Employee' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'surname' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_surname',
    writer  => 'set_surname',
);
has 'email' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_email',
    writer  => 'set_email',
);
has 'password' => (
    is => 'rw',
    reader => 'get_password',
    writer => 'set_password',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Employee';

sub validate_name {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}
sub validate_surname    {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('surname')->type_constraint->validate($value);
}
sub validate_email      {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('email')->type_constraint->validate($value);
}
sub validate_password   { 1 }

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
        name         => $self->get_name,
        surname      => $self->get_surname,
        email        => $self->get_email,
        password     => $self->get_password,
        is_published => $self->get_is_published,
    };
}

__PACKAGE__->meta->make_immutable();

1;
