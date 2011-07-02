package ClubSpain::Schema::Result::Country;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('country');
__PACKAGE__->source_name('Country');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    name => {
        data_type     => 'char',
        size          => 254,
        is_nullable   => 0,
    },
    alpha2 => {
        data_type     => 'char',
        size          => 2,
        is_nullable   => 0,
    },
    alpha3 => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    numerics => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_name => [qw(name)]);
__PACKAGE__->add_unique_constraint(on_alpha2  => [qw(alpha2)]);
__PACKAGE__->add_unique_constraint(on_alpha3  => [qw(alpha3)]);
__PACKAGE__->add_unique_constraint(on_numerics => [qw(numerics)]);

__PACKAGE__->has_many(
    cities => 'ClubSpain::Schema::Result::City',
    { 'foreign.country_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
