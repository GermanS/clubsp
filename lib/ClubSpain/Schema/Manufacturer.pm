package ClubSpain::Schema::Manufacturer;

use strict;
use warnings;

BEGIN {
    use base qw(DBIx::Class);
};

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('manufacturer');
__PACKAGE__->source_name('Manufacturer');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    code => {
        data_type   => 'char',
        size        => 254,
        is_nullable => 0
    },
    name => {
        data_type   => 'char',
        size        => 254,
        is_nullable => 0,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_code => [qw(code)]);

#__PACKAGE__->has_many('items' => 'AviaBroker::Schema::DBIC::AirCraft', {'foreign.manufacturer_id' => 'self.id'} );

1;
