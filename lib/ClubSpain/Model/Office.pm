package ClubSpain::Model::Office;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Office' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'company_id' => (
    is      => 'rw',
    reader  => 'get_company_id',
    writer  => 'set_company_id',
);
has 'zipcode' => (
    is      => 'rw',
    reader  => 'get_zipcode',
    writer  => 'set_zipcode',
);
has 'street' => (
    is      => 'rw',
    reader  => 'get_street',
    writer  => 'set_street',
);
has 'name'  => (
    is      => 'rw',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'is_published' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 1,
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        company_id  => $self->get_company_id,
        zipcode     => $self->get_zipcode,
        street      => $self->get_street,
        name        => $self->get_name,
        is_published => $self->get_is_published
    };
}

__PACKAGE__->meta()->make_immutable;

1;
