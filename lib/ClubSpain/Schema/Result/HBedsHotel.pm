package ClubSpain::Schema::Result::HBedsHotel;
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
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    code => {
        data_type      => 'MEDIUMINT(6) UNSIGNED',
        is_nullable    => 0,
    },
    name => {
        data_type     => 'VARCHAR',
        size          => 52,
        is_nullable   => 0,
    },
    address => {
        data_type     => 'varchar',
        size          => 100,
        is_nullable   => 0,
    },
    number => {
        data_type     => 'varchar',
        size          => 10,
        is_nullable   => 0,
    },
    postalCode => {
        data_type     => 'varchar',
        size          => 20,
        is_nullable   => 0,
    },
    phoneHotel => {
        data_type     => 'varchar',
        size          => 15,
        is_nullable   => 0,
    },
    phoneResv => {
        data_type     => 'varchar',
        size          => 15,
        is_nullable   => 0,
    },
    fax => {
        data_type     => 'varchar',
        size          => 15,
        is_nullable   => 0,
    },
    email => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
    webSite => {
        data_type     => 'varchar',
        size          => 50,
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
    description => {
        data_type     => 'text',
    },
    status => {
        data_type     => 'varchar',
        size          => 2,
        is_nullable   => 0,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    'city' => 'ClubSpain::Schema::Result::HBedsCity', 'city_id'
);
__PACKAGE__->belongs_to(
    'category' => 'ClubSpain::Schema::Result::HBedsCategory', 'category_id'
);
__PACKAGE__->belongs_to(
    'zone' => 'ClubSpain::Schema::Result::HBedsZone', 'zone_id'
);
__PACKAGE__->might_have(
    'chain' => 'ClubSpain::Schema::Result::HBedsChain',
    { 'foreign.id' => 'self.chain_id' },
    { cascade_delete => 0 }
);

1;
