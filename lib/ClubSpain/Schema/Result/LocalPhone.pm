package ClubSpain::Schema::Result::LocalPhone;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('local_phone');
__PACKAGE__->source_name('LocalPhone');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    office_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    number => {
        data_type     => 'indeger',
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'TINYINT(1) UNSIGNED',
        is_nullable    => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to(
    'office' => 'ClubSpain::Schema::Result::Office', 'office_id'
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
