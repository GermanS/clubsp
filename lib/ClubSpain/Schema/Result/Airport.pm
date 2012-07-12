package ClubSpain::Schema::Result::Airport;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


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
    },
    is_published => {
        data_type     => 'TINYINT(1) UNSIGNED',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_icao => [qw(icao)]);

__PACKAGE__->belongs_to(
    'city' => 'ClubSpain::Schema::Result::City', 'city_id'
);
__PACKAGE__->has_many(
    'departure_flights' => 'ClubSpain::Schema::Result::Flight',
    { 'foreign.departure_airport_id' => 'self.id' },
    { cascade_delete => 0 }
);
__PACKAGE__->has_many(
    'arrival_flights' => 'ClubSpain::Schema::Result::Flight',
    { 'foreign.destination_airport_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

sub to_hash {
    my $self = shift;

    return {
        id   => $self->id,
        name => $self->name,
        iata => $self->iata,
    };
}

1;
