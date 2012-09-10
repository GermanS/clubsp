package ClubSpain::Model::Company;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Company' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'zipcode' => (
    is      => 'rw',
    reader  => 'get_zipcode',
    writer  => 'set_zipcode',
);
has 'street'=> (
    is      => 'rw',
    reader  => 'get_street',
    writer  => 'set_street',
);
has 'name' => (
    is      => 'rw',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'nick' => (
    is      => 'rw',
    reader  => 'get_nick',
    writer  => 'set_nick',
);
has 'website' => (
    is      => 'rw',
    reader  => 'get_website',
    writer  => 'set_website',
);
has 'INN' => (
    is      => 'rw',
    reader  => 'get_INN',
    writer  => 'set_INN',
);
has 'OKPO' => (
    is      => 'rw',
    reader  => 'get_OKPO',
    writer  => 'set_OKPO',
);
has 'OKVED' => (
    is      => 'rw',
    reader  => 'get_OKVED',
    writer  => 'set_OKVED',
);
has 'is_NDS' => (
    is      => 'rw',
    reader  => 'get_is_NDS',
    writer  => 'set_is_NDS',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Company';

sub validate_zipcode {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('zipcode')->type_constraint->validate($value);
}
sub validate_street  {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('street')->type_constraint->validate($value);
}
sub validate_name {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}
sub validate_nick {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('nick')->type_constraint->validate($value);
}
sub validate_website {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('website')->type_constraint->validate($value);
}
sub validate_INN  {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('INN')->type_constraint->validate($value);
}
sub validate_OKPO {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('OKPO')->type_constraint->validate($value);
}
sub validate_OKVED {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('OKVED')->type_constraint->validate($value);
}
sub validate_is_NDS  {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('is_NDS')->type_constraint->validate($value);
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
        zipcode => $self->get_zipcode,
        street  => $self->get_street,
        name    => $self->get_name,
        nick    => $self->get_nick,
        website => $self->get_website,
        INN     => $self->get_INN,
        OKPO    => $self->get_OKPO,
        OKVED   => $self->get_OKVED,
        is_NDS  => $self->get_is_NDS,
        is_published => $self->get_is_published
    };
}


__PACKAGE__->meta->make_immutable();

1;
