package ClubSpain::Schema::Terminal;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('terminal');
__PACKAGE__->source_name('Terminal');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    airport_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    name => {
        data_type     => 'char',
        size          => 255,
        is_nullable   => 0,
    },
    is_published => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many( departures => 'ClubSpain::Schema::TimeTable', {'foreign.departure_terminal_id' => 'self.id'} );
__PACKAGE__->has_many( arrivals   => 'ClubSpain::Schema::TimeTable', {'foreign.arrival_terminal_id' => 'self.id'} );

1;
