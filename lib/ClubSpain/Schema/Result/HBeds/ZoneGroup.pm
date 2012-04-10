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
        data_type         => 'SMALLINT(4) UNSIGNED',
        is_auto_increment => 1
    },
    city_id => {
        data_type      => 'SMALLINT(4) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    code => {
        data_type     => 'varchar',
        size          => 11,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 43,
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code => [qw(code)]);

__PACKAGE__->belongs_to(
    'city' => 'ClubSpain::Schema::Result::HBedsCity', 'city_id'
);
__PACKAGE__->has_many(
    zones => 'ClubSpain::Schema::Result::HBedsZone',
    { 'foreign.zone_group_id' => 'self.id' },
    { cascade_delete => 0 }
);

1;
