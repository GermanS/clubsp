package ClubSpain::Schema::Result::HBeds::City;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_city');
__PACKAGE__->source_name('HBedsCity');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'SMALLINT(4) UNSIGNED',
        is_auto_increment => 1
    },
    country_id => {
        data_type      => 'TINYINT(3) UNSIGNED',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    code => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 43,
        is_nullable   => 0
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_iata => [qw(code)]);
__PACKAGE__->add_unique_constraint(on_country_id_name => [qw(country_id name)]);

__PACKAGE__->belongs_to(
    'country' => 'ClubSpain::Schema::Result::HBeds::Country', 'country_id'
);
__PACKAGE__->has_many(
    zone_groups => 'ClubSpain::Schema::Result::HBeds::Zone',
    { 'foreign.city_id' => 'self.id' },
    { cascade_delete => 0 }
);
__PACKAGE__->has_many(
    hotels => 'ClubSpain::Schema::Result::HBeds::Hotel',
    { 'foreign.city_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
