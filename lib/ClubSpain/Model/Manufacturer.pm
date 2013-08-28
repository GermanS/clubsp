package ClubSpain::Model::Manufacturer;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Manufacturer' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'code' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_code',
    writer  => 'set_code',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);

with 'ClubSpain::Model::Role::Manufacturer';

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Manufacturer

=head1 SYNOPSIS

use ClubSpain::Model::Manufacturer;
my $object = ClubSpain::Model::Manufacturer -> new(
    id   => $id,
    code => $code,
    name => $name,
);

my $res = $object -> create();
my $res = $object -> update();

=head1 DESCRIPTION

Производитель самолетов

=head1 FIELDS

=head2 id

Идентификатор производителя

=head2 code

Код производителя

=head2 name

Название производителя

=head1 METHODS

=head2 create()

Добавление записи в базу данных

=head2 update()

Редактирование записи в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::Manufacturer>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut