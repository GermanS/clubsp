package ClubSpain::Schema::Result::Airport;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'airport' );
__PACKAGE__ -> source_name( 'Airport' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    city_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        default_value  => 0,
        is_foreign_key => 1,
    },
    iata => {
        data_type   => 'char',
        size        => 3,
        is_nullable => 0,
    },
    icao => {
        data_type   => 'char',
        size        => 4,
        is_nullable => 0,
    },
    name => {
        data_type   => 'char',
        size        => 50,
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
);

__PACKAGE__ -> set_primary_key( 'id' );
__PACKAGE__ -> add_unique_constraint( on_icao => [ qw(icao) ] );

__PACKAGE__ -> belongs_to(
    'city' => 'ClubSpain::Schema::Result::City', 'city_id'
);
__PACKAGE__ -> has_many(
    'departure_flights' => 'ClubSpain::Schema::Result::Flight',
    { 'foreign.departure_airport_id' => 'self.id' },
    { cascade_delete => 0 }
);
__PACKAGE__->has_many(
    'arrival_flights' => 'ClubSpain::Schema::Result::Flight',
    { 'foreign.destination_airport_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

sub to_hash {
    my $self = shift;

    return {
        id   => $self -> id,
        name => $self -> name,
        iata => $self -> iata,
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Airport

=head1 DESCRIPTION

Модель таблицы airport - название аэропорта

=head1 FIELDS

=head2 id

Идентификатор аэропорта

=head2 city_id

Идентфикатор города

=head2 iata

IATA код аэропорта

=head2 icao

ICAO код аэропорта

=head2 name

Название аэропорта

=head2 is_published

Флаг олпубликованности аэропорта.
true  - аэропорт опубликоваен
false - аэропорт скрыт

=head1 INDEXES

=head2 on_icao

Уникальный индекс по полю icao

=head1 METHODS

=head2 city

Получение города, к которому принадлежит аэропорт

=head2 departure_flights

Получение списка рейсов отправления из аэропорта

=head2 arrival_flights

Получение списка рейсов прибытия в аэропорт

=head1 SEE ALSO

L<ClubSpain::Schema::Result::City>
L<ClubSpain::Schema::Result::Flight>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut