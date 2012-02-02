package ClubSpain::Schema::Result::HBedsZone;
use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_zone');
__PACKAGE__->source_name('HBedsZone');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'SMALLINT(4) UNSIGNED',
        is_auto_increment => 1
    },
    zone_group_id => {
        data_type      => 'SMALLINT(4) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    code => {
        data_type     => 'TINYINT(3) UNSIGNED',
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 46,
        is_nullable   => 0,
    }
);

__PACKAGE__->set_primary_key('id');
#__PACKAGE__->add_unique_constraint(on_code => [qw(code)]);

__PACKAGE__->belongs_to(
    'zone_group' => 'ClubSpain::Schema::Result::HBedsZoneGroup', 'zone_group_id'
);
__PACKAGE__->has_many(
    hotels => 'ClubSpain::Schema::Result::HBedsHotel',
    { 'foreign.zone_id' => 'self.id' },
    { cascade_delete => 0 }
);

1;
