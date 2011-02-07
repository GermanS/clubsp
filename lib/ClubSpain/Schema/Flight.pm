package ClubSpain::Schema::Flight;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('flight');
__PACKAGE__->source_name('Flight');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    is_published => {
        data_type      => 'integer',
        is_nullable    => 0,
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

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_primary_key => [qw(departure_airport_id destination_airport_id airline_id code)]);

__PACKAGE__->belongs_to('airline' => 'ClubSpain::Schema::Airline', 'airline_id');
__PACKAGE__->belongs_to('departure_airport'   => 'ClubSpain::Schema::Airport', 'departure_airport_id');
__PACKAGE__->belongs_to('destination_airport' => 'ClubSpain::Schema::Airport', 'destination_airport_id');

1;
