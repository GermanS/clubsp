package ClubSpain::Model::Airport;

use strict;
use warnings;
use utf8;

use ClubSpain::Types;

use Moose;
use namespace::autoclean;
use parent qw(ClubSpain::Model::Base);

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airport' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'city_id' => (
    is      => 'rw',
    reader  => 'get_city_id',
    writer  => 'set_city_id',
);
has 'iata' => (
    is      => 'rw',
    isa     => 'AlphaLength3',
    reader  => 'get_iata',
    writer  => 'set_iata',
);
has 'icao' => (
    is      => 'rw',
    isa     => 'AlphaLength4',
    reader  => 'get_icao',
    writer  => 'set_icao',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with qw(ClubSpain::Model::Role::Airport);

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

sub searchAirportsOfDeparture {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( $self -> source_name() )
              -> searchAirportsOfDeparture( %params );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=head1 NAME

ClubSpian::Model::Airport

=head1 SYNOPSIS

    use ClubSpain::Model::Airport;
    my $object = ClubSpiain::Model::Airport -> new(
        id           => $id,
        name         => $name,
        iata         => $iata,
        icao         => $icao,
        city_id      => $city_id,
        is_published => $flag,
    );

    if( $object -> validate_name() ) { ... }
    if( $object -> validate_iata() ) { ... }
    if( $object -> validate_icao() ) { ... }
    if( $object -> validate_city_id() ) { ... }

    my $res = $object -> create();
    my $res = $object -> update();
    my $res = $object -> delete();
    my $iterator = $object -> searchAirportsOfDeparture( %params )

=head1 DESCRIPTION

Аэропорт

=head1 FIELDS

=head2 id

Идентификатор аэропорта

=head2 city_id

Идентификатор города

=head2 iata

IATA код аэропорта

=head2 icao

ICAO код аэропорта

=head2 name

Название аэропорта

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head1 create()

Добавление аэропорта в дазу данных

=head1 update()

Обновление информации об аэропорте

=head1 searchAirportsOfDeparture(%params)

Поиск аэропортов отправления по заданным критериям

=head1 SEE ALSO

L<ClubSpain::Model::Role::Airport>
L<ClubSpian::Model::Base>
L<Moose>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut