package ClubSpain::Model::Role::Article;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_parent_id   set_parent_id
    get_header      set_header
    get_subheader   set_subheader
    get_body        set_body
);

sub notify {
    my ($self, $object) = @_;

    $self -> set_parent_id( $object -> get_parent_id() || 0);
    $self -> set_header( $object -> get_header() );
    $self -> set_subheader( $object -> get_subheader() );
    $self -> set_body( $object -> get_body() );
}

sub validate_parent_id { 1; }
sub validate_header    { 1; }
sub validate_subheader { 1; }
sub validate_body      { 1; }

sub params {
    my $self = shift;

    return {
        parent_id    => $self -> get_parent_id(),
        weight       => $self -> get_weight(),
        header       => $self -> get_header(),
        subheader    => $self -> get_subheader(),
        body         => $self -> get_body(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Article

=head1 DESCRIPTION

Интерфейсные методы для статей

=head1 METHODS

=head2 validate_parent_id()

Проверка идентификатора родительской статьи

=head2 validate_header()

Провека заголовка

=head2 validate_subheader()

Проверка подзаголовка

=head2 validate_body()

Проверка длины тела статьи

=head2 notify()

#TODO: написать пояснение для notify()

=head2 params()

#TODO: написать пояснения для params()

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut