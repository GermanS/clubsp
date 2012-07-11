package ClubSpain::Schema::Result::Employee;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('employee');
__PACKAGE__->source_name('Employee');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    name => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
    surname => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
    email => {
        data_type     => 'varchar',
        size          => 50,
        is_nullable   => 0,
    },
    passwd => {
        data_type     => 'varchar',
        size          => 64,
        is_nullable   => 0,
    },
    is_published => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_icao => [qw(email)]);


sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
