package ClubSpain::Schema::Result::HBeds::FacilityGroup;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_facility_group');
__PACKAGE__->source_name('HBedsFaciltyGroup');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'TINYINT(3) UNSIGNED',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'varchar',
        size          => 3,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'varchar',
        size          => 100,
        is_nullable   => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code  => [qw(code)]);

#__PACKAGE__->has_many(
#    cities => 'ClubSpain::Schema::Result::HBeds::City',
#    { 'foreign.country_id' => 'self.id' },
#    { cascade_delete => 0 }
#);

#sub sqlt_deploy_hook {
#    my ($self, $sqlt_table) = @_;

#    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
#}

1;
