package ClubSpain::Schema::Result::Fare;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('fare');
__PACKAGE__->source_name('Fare');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    fare => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many(
    'segments' => 'ClubSpain::Schema::Result::Segment', {'foreign.fare_id' => 'self.id'}
);

1;
