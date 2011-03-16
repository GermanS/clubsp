package ClubSpain::Schema::Result::Itinerary;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('itinerary');
__PACKAGE__->source_name('Itinerary');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    timetable_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    fare_class_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    parent_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 0,
    },
    cost => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 0,
    }
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    'timetable'  => 'ClubSpain::Schema::Result::TimeTable', 'timetable_id'
);
__PACKAGE__->belongs_to(
    'fare_class'       => 'ClubSpain::Schema::Result::FareClass', 'fare_class_id'
);

1;
