package ClubSpain::Schema::Result::Airline;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


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

__PACKAGE__->has_many(
    flight => 'ClubSpain::Schema::Result::Flight', {'foreign.airline_id' => 'self.id'}
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}


1;
