package ClubSpain::Schema::Airport;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('airport');
__PACKAGE__->source_name('Airport');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    city_id => {
        data_type     => 'integer',
        is_nullable   => 0,
        default_value => 0,
        is_foreign_key=> 1,
    },
    iata => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    icao => {
        data_type     => 'char',
        size          => 4,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 50,
        is_nullable   => 0,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_icao => [qw(icao)]);

__PACKAGE__->belongs_to('city' => 'ClubSpain::Schema::City', 'city_id');
#__PACKAGE__->has_many('departure_flights' => 'AviaBroker::Schema::DBIC::Flight',
#    {'foreign.departure_airport' => 'self.id'});
#__PACKAGE__->has_many('arrival_flights' => 'AviaBroker::Schema::DBIC::Flight',
#    {'foreign.arrival_airport' => 'self.id'});

1;
