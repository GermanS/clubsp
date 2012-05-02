package ClubSpain::Schema::Result::HBeds::ZoneGroup;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_zone_group');
__PACKAGE__->source_name('HBedsZoneGroup');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'INT UNSIGNED',
        is_auto_increment => 1
    },
    interface => {
        data_type     => 'VARCHAR(1)',
        is_nullable   => 0,
    },
    code => {
        data_type     => 'VARCHAR(10)',
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_interface_code => [qw(interface code)]);

__PACKAGE__->has_many(
    group_by_zones => 'ClubSpain::Schema::Result::HBeds::ZoneByGroup',
    { 'foreign.group_id' => 'self.id' },
    { cascade_delete => 0 }
);

__PACKAGE__->many_to_many( zones => 'group_by_zones', 'zone' );

1;
