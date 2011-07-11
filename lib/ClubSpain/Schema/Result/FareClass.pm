package ClubSpain::Schema::Result::FareClass;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(ForceUTF8 Core PK::Auto));
__PACKAGE__->table('fare_class');
__PACKAGE__->source_name('FareClass');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    code => {
        data_type     => 'char',
        size          => 1,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 254,
        is_nullable   => 0,
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_name => [qw(code)]);
__PACKAGE__->has_many(
    'itineraries' => 'ClubSpain::Schema::Result::Itinerary',
    { 'foreign.fare_class_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
