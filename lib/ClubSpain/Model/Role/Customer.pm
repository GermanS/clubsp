package ClubSpain::Model::Role::Customer;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_name        set_name
    get_surname     set_surname
    get_email       set_email
    get_passwd      set_passwd
    get_mobile      set_mobile
);

sub notify {
    my ($self, $object) = @_;

    $self -> set_name( $object -> get_name() );
    $self -> set_surname( $object -> get_surname() );
    $self -> set_email( $object -> get_email() );
    $self -> set_passwd( $object -> get_passwd() );
    $self -> set_mobile( $object -> get_mobile() );

    return;
}

sub validate_name    { return 1; }
sub validate_surname { return 1; }
sub validate_email   { return 1; }
sub validate_passwd  { return 1; }
sub validate_mobile  { return 1; }

sub params {
    my $self = shift;

    return {
        name         => $self -> get_name(),
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

ClubSpain::Model::Role::Customer

=head1 DESCRIPTION

=head1 METHODS

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

=head2 notify()

#TODO: написать документацию

=head2 params()

#TODO: написать документацию

=head1 SEE ALSO

L<ClubSpain::Model::Customer>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut