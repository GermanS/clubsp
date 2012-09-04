package ClubSpain::Model::Employee;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Employee' });

has 'id'            => ( is => 'rw' );
has 'first_name'    => ( is => 'rw' );
has 'surname'       => ( is => 'rw' );
has 'email'         => ( is => 'rw' );
has 'password'      => ( is => 'rw' );
has 'is_published'  => ( is => 'rw' );

with 'ClubSpain::Model::Role::Employee';

sub validate_first_name { 1 }
sub validate_surname    { 1 }
sub validate_email      { 1 }
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
        name         => $self->first_name,
        surname      => $self->surname,
        email        => $self->email,
        password     => $self->password,
        is_published => $self->is_published,
    };
}

__PACKAGE__->meta->make_immutable();

1;
