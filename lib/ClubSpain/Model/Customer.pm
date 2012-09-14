package ClubSpain::Model::Customer;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Customer' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'name' => (
    is      => 'rw',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'surname' => (
    is      => 'rw',
    reader  => 'get_surname',
    writer  => 'set_surname',
);
has 'email' => (
    is      => 'rw',
    reader  => 'get_email',
    writer  => 'set_email',
);
has 'passwd' => (
    is      => 'rw',
    reader  => 'get_passwd',
    writer  => 'set_passwd',
);
has 'mobile' => (
    is      => 'rw',
    isa     => 'MobilePhoneNumber',
    reader  => 'get_mobile',
    writer  => 'set_mobile',
);
has 'is_published' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 1,
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Customer';

sub validate_name    { 1; }
sub validate_surname { 1; }
sub validate_email   { 1; }
sub validate_passwd  { 1; }
sub validate_mobile  { 1; }

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
        passwd       => $self->get_passwd,
        mobile       => $self->get_mobile,
        is_published => $self->get_is_published,
    };
}

__PACKAGE__->meta->make_immutable();

1;
