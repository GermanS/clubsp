package ClubSpain::Model::Flight;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Flight' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'airport_of_departure' => (
    is      => 'rw',
    reader  => 'get_airport_of_departure',
    writer  => 'set_airport_of_departure',
);
has 'airport_of_arrival' => (
    is      => 'rw',
    reader  => 'get_airport_of_arrival',
    writer  => 'set_airport_of_arrival',
);
has 'airline_id' => (
    is      => 'rw',
    reader  => 'get_airline_id',
    writer  => 'set_airline_id',
);
has 'code' => (
    is      => 'rw',
    isa     => 'NaturalLessThan10000',
    reader  => 'get_code',
    writer  => 'set_code',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Flight';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

sub searchFlights {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( $self -> source_name() )
              -> searchFlights(%params);
}

sub searchFlightsInTimetable {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset( $self -> source_name()  )
              -> searchFlightsInTimetable(%params);
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Flight

=head1 SYNOPSIS

    use ClubSpain::Model::Flight;
    my $object = ClubSpain::Model::Flight -> new(
        id                   => $id,
        airport_of_departure => $airport_of_departure,
        airport_of_arrival   => $airport_of_arrival,
        airline_id           => $airline_id,
        code                 => $code,
        is_published         => $flag,
    );

    my $res = $object -> create();
    my $res = $object -> update();

    my $iterator = $object -> searchFlights( %params );
    my $iterator = $object -> searchFlightsInTimeTable( %params );

=head1 DESCRIPTION

Рейс, полетный сегмент

=head1 FIELDS

=head2 id

Идентфикатор сегмента

=head2 airport_of_departure

Аэропорт отправления

=head2 airport_of_arrival

Аэропорт прибытия

=head2 airline_id

Авиакомпания

=head2 code

Код (номер) рейса

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Редактирование записи в базе данных

=head2 searchFlights(%params)

Поиск рейсов, удовлетворяющих критериям %params

=head2 searchFlightsInTimetable(%params)

Поиск рейсов, у которых есть уктуально ерасписание, удовлетворяющих условию

=head1 SEE ALSO

L<ClubSpain::Model::Role::Flight>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

-cut