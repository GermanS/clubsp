package ClubSpain::Schema::Airline;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('airline');
__PACKAGE__->source_name('Airline');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    iata => {
        data_type     => 'char',
        size          => 2,
        is_nullable   => 0,
    },
    icao => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 255,
        is_nullable   => 0,
    },
    is_published => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_icao => [qw(icao)]);

__PACKAGE__->has_many( flight => 'ClubSpain::Schema::Flight', {'foreign.airline_id' => 'self.id'} );

1;
