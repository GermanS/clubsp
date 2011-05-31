package ClubSpain::Schema::Result::TimeTable;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('timetable');
__PACKAGE__->source_name('TimeTable');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    is_published => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
    flight_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    airplane_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    departure_terminal_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    arrival_terminal_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    departure_date => {
        data_type      => 'date',
        is_nullable    => 0,
    },
    departure_time => {
        data_type      => 'time',
        is_nullable    => 1,
    },
    arrival_date => {
        data_type      => 'date',
        is_nullable    => 0,
    },
    arrival_time => {
        data_type      => 'time',
        is_nullable    => 1,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_flight_departure_date => [qw(flight_id departure_date arrival_date)]);

__PACKAGE__->belongs_to(
    'departure_terminal' => 'ClubSpain::Schema::Result::Terminal', 'departure_terminal_id'
);
__PACKAGE__->belongs_to(
    'arrival_terminal'   => 'ClubSpain::Schema::Result::Terminal', 'arrival_terminal_id'
);
__PACKAGE__->belongs_to(
    'flight'   => 'ClubSpain::Schema::Result::Flight', 'flight_id'
);
__PACKAGE__->belongs_to(
    'airplane' => 'ClubSpain::Schema::Result::Airplane', 'airplane_id'
);

__PACKAGE__->has_many(
    'itineraries' => 'ClubSpain::Schema::Result::Itinerary',
    { 'foreign.timetable_id' => 'self.id' },
    { cascade_delete => 0 }
);


1;