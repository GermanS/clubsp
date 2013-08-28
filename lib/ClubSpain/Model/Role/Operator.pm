package ClubSpain::Model::Role::Operator;

use strict;
use warnings;
use utf8;

use Moose::Role;

sub validate_name      { return 1; }
sub validate_office_id { return 1; }
sub validate_surname   { return 1; }
sub validate_email     { return 1; }
sub validate_passwd    { return 1; }
sub validate_mobile    { return 1; }

sub params {
    my $self = shift;

    return {
        name         => $self -> get_name(),
        office_id    => $self -> get_office_id(),
        surname      => $self -> get_surname(),
        email        => $self -> get_email(),
        passwd       => $self -> get_passwd(),
        mobile       => $self -> get_mobile(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Operator;

=head1 DESCRIPTION

Интерфейсные методя для работы с сотрудников компании

=head1 METHODS

=head2 validate_office_id()

Проверка идентификатор а офиса

=head2 validate_name()

Проверка имени

=head2 validate_surname()

Проверка фамилии

=head2 validate_email()

Проверка адреса электронной почты

=head2 validate_passwd()

Проверка пароля

=head2 validate_mobile()

Проверка номера мобильного телефона

=head2 params()

#TODO: документация params()

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut