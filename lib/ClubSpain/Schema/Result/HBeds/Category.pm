package ClubSpain::Schema::Result::HBeds::Category;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_category');
__PACKAGE__->source_name('HBedsCategory');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'TINYINT(3) UNSIGNED',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'varchar',
        size          => 5,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 100,
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
#__PACKAGE__->add_unique_constraint(on_code => [qw(code)]);

__PACKAGE__->has_many(
    hotels => 'ClubSpain::Schema::Result::HBedsHotel',
    { 'foreign.category_id' => 'self.id' },
    { cascade_delete => 0 }
);

1;
