package ClubSpain::Model::Role::Employee;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_name     set_name
    get_surname  set_surname
    get_email    set_email
    get_password set_password
);

sub validate_name {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('name') -> type_constraint -> validate($value);
}

sub validate_surname    {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('surname') -> type_constraint -> validate($value);
}

sub validate_email      {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('email') -> type_constraint -> validate($value);
}

sub validate_password   {
    return 1;
}

sub notify {
    my ($self, $object) = @_;

    $self -> set_name( $object -> get_name() );
    $self -> set_surname( $object -> get_surname() );
    $self -> set_email( $object -> get_email() );
    $self -> set_password( $object -> get_password() );

    return;
}

sub params {
    my $self = shift;

    return {
        name         => $self -> get_name(),
        surname      => $self -> get_surname(),
        email        => $self -> get_email(),
        password     => $self -> get_password(),
        is_published => $self -> get_is_published(),
    };
}

1;


__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Employee

=head1 DESCRIPTION

Интерфейсные методы для работника организации

=head1 METHODS

=head2 valudate_name()

Проверка имени

=head2 validate_surname()

Проверка фамилии

=head2 validate_email()

Проверка адреса элетронной почты

=head2 validate_password()

Проверка пароля

=head2 notify()

#TODO: сделать документацию

=head2 params()

#TODO: сделать докумнтацию

=head1 SEE ALSO

L<ClubSpain::Model::Employee>
L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut
