package ClubSpain::Schema::TimeTable;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

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

__PACKAGE__->belongs_to('departure_terminal' => 'ClubSpain::Schema::Terminal', 'departure_terminal_id');
__PACKAGE__->belongs_to('arrival_terminal'   => 'ClubSpain::Schema::Terminal', 'arrival_terminal_id');
__PACKAGE__->belongs_to('flight'   => 'ClubSpain::Schema::Flight', 'flight_id');
__PACKAGE__->belongs_to('airplane' => 'ClubSpain::Schema::Airplane', 'airplane_id');

1;
