package ClubSpain::Model::City;

use strict;
use warnings;
use utf8;

use Moose;
use namespace::autoclean;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub { 'City' } );

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'country_id' => (
    is      => 'rw',
    reader  => 'get_country_id',
    writer  => 'set_country_id',
);
has 'iata' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength3',
    reader  => 'get_iata',
    writer  => 'set_iata',
);
has 'name_en' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name_en',
    writer  => 'set_name_en',
);
has 'name_ru' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name_ru',
    writer  => 'set_name_ru',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::City';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}


sub searchCitiesOfDeparture {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( $self -> source_name() )
              -> searchCitiesOfDeparture( %params );
}

sub searchCitiesOfDepartureInFlight {
    my $self = shift;

    return
        $self -> schema()
              -> resultset( 'ViewFlight' )
              -> searchCitiesOfDeparture();
}

sub searchCitiesOfArrivalInFlight {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( 'ViewFlight' )
              -> searchCitiesOfArrival( %params );
}

sub searchCitiesOfDepartureOW {
    my $self = shift;

    return
        $self -> schema()
              -> resultset( 'ViewItineraryOW' )
              -> searchCitiesOfDeparture();
}

sub searchCitiesOfArrivalOW {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( 'ViewItineraryOW' )
              -> searchCitiesOfArrival( %params );
}

sub searchCitiesOfDeparture1RT {
    my $self = shift;

    return
        $self -> schema()
              -> resultset( 'ViewItineraryRT' )
              -> searchCitiesOfDeparture1();
}

sub searchCitiesOfArrival1RT {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( 'ViewItineraryRT' )
              -> searchCitiesOfArrival1( %params );
}

sub searchCitiesOfDeparture2RT {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( 'ViewItineraryRT' )
              -> searchCitiesOfDeparture2( %params );
}

sub searchCitiesOfArrival2RT {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( 'ViewItineraryRT' )
              -> searchCitiesOfArrival2( %params );
}

sub suggest {
    my ($self, $string) = @_;

    $string ||= '';
    my $result;
    return $result if length( $string ) < 3;

    if ( $string =~ m/^([a-z]*)$/i ) {
        if (length $string == 3) {
            $result = $self -> _search_by_iata($string);
        }

        unless ($result && ( $result -> can('count') && $result -> count() )) {
            $result = $self -> _search_like_by_name($string);
        }
    } elsif ( $string =~ m/^([а-я])*$/i ) {
        $result = $self -> _search_like_by_name_ru($string);
    }

    return $result
}

sub _search_like_by_name {
    my ($self, $string) = @_;

    return $self -> search({ name => \"LIKE '$string%'"}, {});
}

sub _search_like_by_name_ru {
    my ($self, $string) = @_;

    return $self -> search({ name_ru => \"LIKE '$string%'"}, {} );
}

sub _search_by_iata {
    my ($self, $iata) = @_;

    return $self -> search({ iata => $iata }, {} );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=head1 NAME

ClubSpain::Model::City

=head1 SYNOPSIS

    use ClubSpain::Model::City;
    my $object = ClubSpain::Model::City -> new(
        id           => $id,
        country_id   => $country_id,
        iata         => $iata,
        name_en      => $name_en,
        name_ru      => $name_ru,
        is_puplished => $flag,
    );

    my $iterator = $object -> searchCitiesOfDeparture();

    my $iterator = $object -> searchCitiesOfDepartureInFlight();
    my $iterator = $object -> searchCitiesOfArrivalInFlight( cityOfDeparture => $id );

    my $iterator = $object -> searchCitiesOfDepartureOW();;
    my $iterator = $object -> searchCitiesOfArrivalOW( cityOfDeparture => $id );

    my $iterator = $object -> searchCitiesOfDeparture1RT( %params );
    my $iterator = $object -> searchCitiesOfArrival1RT( %params );
    my $iterator = $object -> searchCitiesOfDeparture2RT( %params );
    my $iterator = $object -> searchCitiesOfArrival2RT( %params );
    my $iterator = $object -> suggest( 'alicante' );

    my $res = $object -> create();
    my $res = $object -> update();

=head1 DESCRIPTION

Работа с городами

=head1 FIELDS

=head2 id

Идентификатор города

=head2 country_id

Идентификатор страны

=head2 iata

IATA код города

=head2 name_en

Название города латиницей

=head2 name_ru

Русское название города

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Редактирование записи в базе данных

=head2 searchCitiesOfDeparture()

#TODO: описание метода searchCitiesOfDeparture()

=head2 searchCitiesOfDepartureInFlight();

Поиск городов отправление в рейсах (маршрутах)

=head2 searchCitiesOfArrivalInFlight( %params )

Поиск городов прибытия в рейсах (маршрутах)
На входе
    cityOfDepature - город отправления

=head2 searchCitiesOfDepartureOW()

Поиск городов отправления в тарифах в одну сторону.

=head2 searchCitiesOfArrival( %params )

Поис городов прибытия в тарифах в одну сторону.
На входе:
    cityOfDeparture - город отправления

=head2 searchCitiesOfDeparture1RT(%params)

Поиск городов отправления в тарифах в обе стороны
На входе
  cityOfDeparture1 - первый город отправления

На выходе
   Города прибытия.

=head2 searchCitiesOfArrival1RT(%params)

Поиск городов прибытия в тарифах в обе стороны
по указанному городу отправления
На входе
  cityOfDeparture1 - первый город отправления

На выходе
   Города прибытия.

=head2 searchCitiesOfDeparture2RT(%params)

Поиск городов отправления в тарифах в обе стороны
по указанным городам отправления и прибытия
На входе
  cityOfDeparture1 - первый город отправления
  cityOfArrival1   - первый город прибытия

На выходе
   Города отправления.

=head2 searchCitiesOfArrival2RT(%params)

Поиск городов прибытия в тарифах в обе стороны
по указанным городам отправления и прыбытия первого сегмента
и городу отправления второго
На входе
  cityOfDeparture1 - первый город отправления
  cityOfArrival1   - первый город прибытия
  cityOfDeparture2 - второй город отправления

На выходе
   Города прилета.

=head2 suggest($string);

Поиск города по начальным буквам.
Количество букв в строке должно быть не менее 3х.
На входе:
  $string - строка для поиска города

=head1 SEE ALSO

L<ClubSpain::Model::Role::City>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut