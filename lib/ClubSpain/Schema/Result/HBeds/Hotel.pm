package ClubSpain::Schema::Result::HBeds::Hotel;
use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_hotel');
__PACKAGE__->source_name('HBedsHotel');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'SMALLINT(5) UNSIGNED',
        is_auto_increment => 1
    },
    city_id => {
        data_type      => 'SMALLINT(4) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    category_id => {
        data_type      => 'TINYINT(3) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    zone_id => {
        data_type      => 'SMALLINT(4) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    chain_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    code => {
        data_type      => 'varchar(8)',
        is_nullable    => 0,
    },
    name => {
        data_type     => 'VARCHAR',
        size          => 52,
        is_nullable   => 0,
    },
    longitude => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
    latitude => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
    facilities => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    locationDescription => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    roomDescription => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    sportDescription => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    mealsDescription => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    paymentMethods => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    howToGetThere => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
    comments => {
        data_type     => 'varchar',
        size          => 2000,
        is_nullable   => 1,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    'city' => 'ClubSpain::Schema::Result::HBeds::City', 'city_id'
);
__PACKAGE__->belongs_to(
    'category' => 'ClubSpain::Schema::Result::HBeds::Category', 'category_id'
);
__PACKAGE__->belongs_to(
    'zone' => 'ClubSpain::Schema::Result::HBeds::Zone', 'zone_id'
);
#__PACKAGE__->might_have(
#    'chain' => 'ClubSpain::Schema::Result::HBeds::Chain',
#    { 'foreign.id' => 'self.chain_id' },
#    { cascade_delete => 0 }
#);

1;
