package ClubSpain::Schema::Result::Airplane;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('airplane');
__PACKAGE__->source_name('Airplane');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    manufacturer_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    iata => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    icao => {
        data_type     => 'char',
        size          => 4,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 254,
        is_nullable   => 0
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_country_id_name => [qw(manufacturer_id name)]);

__PACKAGE__->belongs_to(
    'manufacturer' => 'ClubSpain::Schema::Result::Manufacturer', 'manufacturer_id'
);
__PACKAGE__->has_many(
    time_tables => 'ClubSpain::Schema::Result::TimeTable',
    { 'foreign.airplane_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
