package ClubSpain::Schema::Result::Terminal;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

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
        data_type     => 'TINYINT(1) UNSIGNED',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many(
    departures => 'ClubSpain::Schema::Result::TimeTable', {'foreign.departure_terminal_id' => 'self.id'}
);
__PACKAGE__->has_many(
    arrivals   => 'ClubSpain::Schema::Result::TimeTable', {'foreign.arrival_terminal_id' => 'self.id'}
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
