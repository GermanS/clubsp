package ClubSpain::Model::Customer;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
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

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

=pod

=head1 NAME
=head1 SYNOPSIS

use ClubSpain::Model::Customer;
my $object = ClubSpain::Model::Customer -> new(
    name         => $self -> get_name(),
    surname      => $self -> get_surname(),
    email        => $self -> get_email(),
    passwd       => $self -> get_passwd(),
    mobile       => $self -> get_mobile(),
    is_published => $self -> get_is_published(),
);
my $res = $object -> create();
my $res = $object -> update();

=head1 DESCRIPTION

Пользователь сервиса

=head1 FIELDS

=head2 id

Идентификатор

=head2 name

Имя пользователя

=head2 surname

Фамилия пользователя

=head2 email

Адрес электронной почты

=head2 passwd

Пароль

=head2 mobile

Номер мобильного телефона

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Редактирование записи в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::Customer>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut