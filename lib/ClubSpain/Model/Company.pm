package ClubSpain::Model::Company;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
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
    isa     => 'StringLength2to255',
    reader  => 'get_street',
    writer  => 'set_street',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'nick' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_nick',
    writer  => 'set_nick',
);
has 'website' => (
    is      => 'rw',
    isa     => 'StringLength2to50',
    reader  => 'get_website',
    writer  => 'set_website',
);
has 'INN' => (
    is      => 'rw',
    isa     => 'INN',
    reader  => 'get_INN',
    writer  => 'set_INN',
);
has 'OKPO' => (
    is      => 'rw',
    isa     => 'OKPO',
    reader  => 'get_OKPO',
    writer  => 'set_OKPO',
);
has 'OKVED' => (
    is      => 'rw',
    isa     => 'StringLength2to50',
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

sub create {
    my $self = shift;

    $self -> SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self->params() );
}

__PACKAGE__-> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Company

=head1 SYNOPSIS

use ClubSpain::Model::Company;
my $object = ClubSpain::Model::Company -> new(
    zipcode      => $zipcode,
    street       => $street,
    name         => $name,
    nick         => $nick,
    website      => $website,
    INN          => $INN
    OKPO         => $OKPO
    OKVED        => $OKVED
    is_NDS       => $is_NDS,
    is_published => $is_published,
);

=head1 DESCRIPTION

Предприятие

=head1 FIELDS

=head2 id

Идентификатор предприятия

=head2 zipcode

Почтовый индекс предприятия

=head2 street

Адрес предприятия

=head2 name

Полное название компании

=head2 nick

Сокращенное название компании

=head2 website

Адрес сайта

=head2 INN

ИНН

=head2 OKPO

ОКПО

=head2 OKVED

ОКВЭД

=head2 is_NDS

Флаг, что компания является платильщиком НДС

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Обновление записи в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::Company>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut