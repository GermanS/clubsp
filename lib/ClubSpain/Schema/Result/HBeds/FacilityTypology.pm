package ClubSpain::Schema::Result::HBeds::FacilityTypology;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_facility_typology');
__PACKAGE__->source_name('HBedsFacilityTopology');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    code=> {
        data_type     => 'varchar',
        size          => 3,
        is_nullable   => 0,
    },
    is_text=> {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_number => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_logic => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_fee => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_distance => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_walking_distance => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_transport_distance => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_car_distance => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_age_from => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_age_to => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_beach_access => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_beach_apart => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_dynamic => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    },
    is_concept => {
        data_type     => 'varchar',
        size          => 1,
        is_nullable   => 0,
    }

);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code => [qw(code)]);

#__PACKAGE__->has_many(
#    hotels => 'ClubSpain::Schema::Result::HBeds::Hotel',
#    { 'foreign.chain_id' => 'self.id' },
#    { cascade_delete => 0 }
#);

1;
