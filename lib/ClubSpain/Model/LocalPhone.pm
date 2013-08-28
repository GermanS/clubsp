package ClubSpain::Model::LocalPhone;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
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
        office_id    => $self -> get_office_id(),
        number       => $self -> get_number(),
        is_published => $self -> get_is_published(),
    };
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::LocalPhone

=head2 SYNOPSIS

use ClubSpain::Model::LocalPhone;
my $object = ClubSpain::Model::LocalPhone -> new(
    id           => $id,
    office_id    => $office_id,
    number       => $number,
    is_published => $flag,
);

my $res = $object -> create();
my $res = $object -> update();

=head1 DESCSRIPTION

Номер городского телефона

=head1 FIELDS

=head2 id

Идентификатор

=head2 office_id

Идентфикатор офиса

=head2 number

Номер телефона

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Добавление записи в базу данных

=head2 update()

Редактирование записи в базе даных

=head2 params()

#TODO: документация для params()

=head1 SEE ALSO

L<Moose>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut