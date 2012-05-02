package ClubSpain::Schema::Result::HBeds::ZoneByGroup;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_zone_by_group');
__PACKAGE__->source_name('HBedsZone');
__PACKAGE__->add_columns(
    zone_id => {
        data_type         => 'SMALLINT(5) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    group_id => {
        data_type      => 'INT UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    }
);

__PACKAGE__->add_unique_constraint(on_zone_group => [qw(zone_id group_id)]);

__PACKAGE__->belongs_to(
    'zone' => 'ClubSpain::Schema::Result::HBeds::Zone', 'zone_id'
);
__PACKAGE__->belongs_to(
    'group' => 'ClubSpain::Schema::Result::HBeds::ZoneGroup', 'group_id'
);

1;
