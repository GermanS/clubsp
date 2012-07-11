package ClubSpain::Model::Employee;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Employee' });

has 'id' => (
    is => 'ro'
);
has 'name' => (
    is => 'ro',
    required => 1,
);
has 'surname' => (
    is => 'ro',
    required => 1,
);
has 'email' => (
    is => 'ro',
    required => 1,
);
has 'passwd' => (
    is => 'ro',
    required => 1
);
has 'is_published' => (
    is => 'ro'
);


sub create {
    my $self = shift;

    $self->SUPER::create({
        name         => $self->name,
        surname      => $self->surname,
        email        => $self->email,
        passwd       => $self->passwd,
        is_published => $self->is_published,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update({
        name         => $self->name,
        surname      => $self->surname,
        email        => $self->email,
        passwd       => $self->passwd,
        is_published => $self->is_published,
    });
}

__PACKAGE__->meta->make_immutable();

1;
