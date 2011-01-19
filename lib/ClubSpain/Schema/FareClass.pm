package ClubSpain::Schema::FareClass;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('fare_class');
__PACKAGE__->source_name('FareClass');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'char',
        size          => 1,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 254,
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_name => [qw(code)]);

1;
