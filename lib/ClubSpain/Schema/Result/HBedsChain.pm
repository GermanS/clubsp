package ClubSpain::Schema::Result::HBedsChain;
use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_chain');
__PACKAGE__->source_name('HBedsChain');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'varchar',
        size          => 5,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 100,
        is_nullable   => 0,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code => [qw(code)]);

__PACKAGE__->has_many(
    hotels => 'ClubSpain::Schema::Result::HBedsHotel',
    { 'foreign.chain_id' => 'self.id' },
    { cascade_delete => 0 }
);

1;
