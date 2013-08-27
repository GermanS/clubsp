package ClubSpain::Model::Role::Country;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_name        set_name
    get_alpha2      set_alpha2
    get_alpha3      get_alpha3
    get_numerics    set_numerics
);

sub notify {
    my ($self, $object) = @_;

    $self -> set_name( $object->get_name() );
    $self -> set_alpha2( $object->get_alpha2() );
    $self -> set_alpha3( $object->get_alpha3() );
    $self -> set_numerics( $object->get_numerics() );

    return;
}

sub validate_name {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'name' ) -> type_constraint -> validate($value);
}

sub validate_alpha2 {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'alpha2' ) -> type_constraint -> validate($value);
}

sub validate_alpha3 {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'alpha3' ) -> type_constraint -> validate($value);
}

sub validate_numerics {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'numerics' ) -> type_constraint -> validate($value);
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Country

=head1 DESCRIPTION

Интерфейсные методы страны

=head1 METHODS

=head2 validate_name()

Проверка названия страны

=head2 validate_alpha2()

Проверка двухбуквенного обозначения страны

=head2 validate_alpha3()

Проверка трезбуквенного кода страны

=head2 validate_numerics()

Проверка цифрового кода страны

=head2 notify()

#TODO: сделать документацию

=head2 params()

#TODO: сделать документацию

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut