package ClubSpain::Schema::Result::Flight;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'flight' );
__PACKAGE__ -> source_name( 'Flight' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
    departure_airport_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    destination_airport_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    airline_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    code => {
        data_type     => 'integer',
        size          => 4,
        is_nullable   => 0
    }
);

__PACKAGE__ -> set_primary_key('id');
__PACKAGE__ -> add_unique_constraint(on_primary_key => [ qw(departure_airport_id destination_airport_id airline_id code)] );

__PACKAGE__ -> belongs_to(
    'airline' => 'ClubSpain::Schema::Result::Airline', 'airline_id'
);
__PACKAGE__ -> belongs_to(
    'departure_airport'   => 'ClubSpain::Schema::Result::Airport', 'departure_airport_id'
);
__PACKAGE__ -> belongs_to(
    'destination_airport' => 'ClubSpain::Schema::Result::Airport', 'destination_airport_id'
);

__PACKAGE__ -> has_many(
    time_tables => 'ClubSpain::Schema::Result::TimeTable',
    { 'foreign.flight_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index(
        name => 'on_is_published',
        fields => ['is_published']
    );
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Flight

=head1 DESCRIPTION

Модель таблицы flight - полетный маршрут.

=head1 FIELDS

=head2 id

Идентификатор полетного маршрута

=head2 is_published

Флаг доступности/опубликованности

=head2 departure_airport_id

Идентификатор аэропорта отправления

=head2 destination_airport_id

Идентификатор аэропорта прибытия

=head2 airline_id

Идентификатор авиакомпании

=head2 code

Код рейса

=head1 INDEXES

=head2 on_primery_key

Уникальный индекс на поля departure_airport_id destination_airport_id airline_id code

=head1 METHODS

=head2 airline

Получение авиакомании, выполняющей рейс

=head2 departure_airport

Получений аэропорта отправления

=head2 destination_airport

Получение аэропорта прибытия

=head2 timetables

Получение списка расписаний для рейса

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Airline>
L<ClubSpain::Schema::Result::Airport>
L<ClubSpain::Schema::Result::TimeTable>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut
