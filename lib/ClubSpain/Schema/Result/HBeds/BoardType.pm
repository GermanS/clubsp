package ClubSpain::Schema::Result::HBeds::BoardType;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_board_type');
__PACKAGE__->source_name('HBedsBoardType');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'INT UNSIGNED',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'varchar',
        size          => 7,
        is_nullable   => 0,
    },
    shortname => {
        data_type     => 'varchar',
        size          => 2,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code  => [qw(code)]);

1;
