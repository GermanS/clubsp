package ClubSpain::Schema::Segment;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core));
__PACKAGE__->table('segment');
__PACKAGE__->source_name('Segment');
__PACKAGE__->add_columns(
    timetable_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    fare_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    fare_class_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
 );

 __PACKAGE__->add_unique_constraint(on_timetable_class_price => [qw(timetable_id fare_id fare_class_id)]);

 __PACKAGE__->belongs_to('timetable'  => 'ClubSpain::Schema::TimeTable', 'timetable_id');
 __PACKAGE__->belongs_to('fare'       => 'ClubSpain::Schema::Fare',      'fare_id');
 __PACKAGE__->belongs_to('fare_class' => 'ClubSpain::Schema::FareClass', 'fare_class_id');


 1;
