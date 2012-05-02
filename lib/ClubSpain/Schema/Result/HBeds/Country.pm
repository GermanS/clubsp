package ClubSpain::Schema::Result::HBeds::Country;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('hbeds_country');
__PACKAGE__->source_name('HBedsCountry');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'TINYINT(3) UNSIGNED',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'char',
        size          => 2,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 40,
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code  => [qw(code)]);
__PACKAGE__->add_unique_constraint(on_name => [qw(name)]);

__PACKAGE__->has_many(
    cities => 'ClubSpain::Schema::Result::HBeds::City',
    { 'foreign.country_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
