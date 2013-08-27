package ClubSpain::Model::Role::Company;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_zipcode set_zipcode
    get_street  set_street
    get_name    set_name
    get_nick    set_nick
    get_website set_website
    get_INN     set_INN
    get_OKPO    set_OKPO
    get_OKVED   set_OKVED
    get_is_NDS  set_is_NDS

);

sub notify {
    my ($self, $object) = @_;

    $self -> set_zipcode( $object->get_zipcode() );
    $self -> set_street( $object->get_street() );
    $self -> set_name( $object->get_name() );
    $self -> set_nick( $object->get_nick() );
    $self -> set_website( $object->get_website() );
    $self -> set_INN( $object->get_INN() );
    $self -> set_OKPO( $object->get_OKPO() );
    $self -> set_OKVED( $object->get_OKVED() );
    $self -> set_is_NDS( $object->get_is_NDS() );

    return;
}

sub params {
    my $self = shift;

    return {
        zipcode      => $self -> get_zipcode(),
        street       => $self -> get_street(),
        name         => $self -> get_name(),
        nick         => $self -> get_nick(),
        website      => $self -> get_website(),
        INN          => $self -> get_INN(),
        OKPO         => $self -> get_OKPO(),
        OKVED        => $self -> get_OKVED(),
        is_NDS       => $self -> get_is_NDS(),
        is_published => $self -> get_is_published(),
    };
}

sub validate_zipcode {
    my ($self, $value) = @_;
    return 1;
}

sub validate_street  {
    my ($self, $value) = @_;
    return 1;
}

sub validate_name {
    my ($self, $value) = @_;
    return 1;
}

sub validate_nick {
    my ($self, $value) = @_;
    return 1;
}

sub validate_website {
    my ($self, $value) = @_;
    return 1;
}

sub validate_INN  {
    my ($self, $value) = @_;
    return 1;
}

sub validate_OKPO {
    my ($self, $value) = @_;
    return 1;
}

sub validate_OKVED {
    my ($self, $value) = @_;
    return 1;
}

sub validate_is_NDS  {
    my ($self, $value) = @_;
    return 1;
}

1;

__END__

=pod

=head1 NAME
=head1 DESCRIPTION
=head1 METHODS

=head2 validate_zipcode()

Проверка почтового интекса предприятия

=head2 validate_street()

ПРоверка реального адреса предприятия

=head2 validate_name()

Проверка названия компании

=head2 validate_nick()

ПРоверка торговой марки компании

=head2 validate_website()

Проверка URL

=head2 validate_INN()

Проверка ИНН

=head2 validate_OKPO()

ПРоверка ОКПО

=head2 validate_OKVED()

Проверка ОКВЭД

=head2 validate_is_NDS()

Проверка, является ли предприятие плательшиком НДС

=head2 notify()

#TOOD: написать документацию

=head2 params()

#TODO: написать документацию

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut