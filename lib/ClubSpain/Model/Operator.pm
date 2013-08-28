package ClubSpain::Model::Operator;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Operator' });

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
with 'ClubSpain::Model::Role::Operator';

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

__END__

=pod

=head1 NAME

ClubSpain::Model::Operator

=head1 SYNOPSIS

use ClubSpain::Model::Operator;
my $object = ClubSpain::Model::Operator -> new(
    name         => $name,
    office_id    => $office_id,
    surname      => $surname,
    email        => $email,
    passwd       => $passwd,
    mobile       => $mobile,
    is_published => $is_published,
);

my $res = $object -> create();
my $res = $object -> update();

=head1 DESCRIPTION

Работник офиса.

=head1 FIELDS

=head2 id

Идентфикатор пользователя

=head2 office_id

Идентфификатор офиса

=head2 name

Имя пользователя

=head2 surname

Фамилия пользователя

=head2 email

Адрес элетронной почты пользователя

=head2 passwd

пароль пользователя

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

L<ClubSpain::Model::Role::Operator>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut