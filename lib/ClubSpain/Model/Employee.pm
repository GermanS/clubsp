package ClubSpain::Model::Employee;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Employee' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'surname' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_surname',
    writer  => 'set_surname',
);
has 'email' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_email',
    writer  => 'set_email',
);
has 'password' => (
    is => 'rw',
    reader => 'get_password',
    writer => 'set_password',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Employee';

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

ClubSpain::Model::Employee

=head1 SYNOPSIS

use ClubSpain::Model::Employee;
my $object = ClubSpain::Model::Employee -> new(
    id           => $id,
    name         => $name,
    surname      => $surname,
    email        => $email,
    password     => $passdord,
    is_published => $flag,
);

my $res = $object -> create();
my $res = $object -> update();

=head1 DESCRIPTION

Пользователь сайта

=head1 FIELDS

=head2 id

Идентификатор пользователя

=head2 name

Имя пользователя

=head2 surname

Фамилия пользователя

=head2 email

Адрес электронной почты пользователя'

=head2 password

Пароль пользователя

=head2 is_published

Флаг опибликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Редактирование записи в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::Employee>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut