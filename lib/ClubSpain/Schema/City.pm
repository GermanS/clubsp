package ClubSpain::Schema::City;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('city');
__PACKAGE__->source_name('City');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    country_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
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
__PACKAGE__->add_unique_constraint(on_country_id_name => [qw(country_id name)]);

__PACKAGE__->belongs_to('country' => 'ClubSpain::Schema::Country', 'country_id');
#__PACKAGE__->has_many( items => 'ClubSpian::Schema::Airport', {'foreign.city_id' => 'self.id'} );

1;
