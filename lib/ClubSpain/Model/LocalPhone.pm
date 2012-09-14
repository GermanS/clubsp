package ClubSpain::Model::LocalPhone;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'LocalPhone' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'office_id' => (
    is      => 'rw',
    reader  => 'get_office_id',
    writer  => 'set_office_id',
);
has 'number' => (
    is      => 'rw',
    isa     => 'LocalPhoneNumber',
    reader  => 'get_number',
    writer  => 'set_number',
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
        office_id   => $self->get_office_id,
        number      => $self->get_number,
        is_published => $self->get_is_published
    };

}

__PACKAGE__->meta()->make_immutable;

1;
