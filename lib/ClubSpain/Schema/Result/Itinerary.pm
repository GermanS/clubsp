package ClubSpain::Schema::Result::Itinerary;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('itinerary');
__PACKAGE__->source_name('Itinerary');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 0,
    },
    timetable_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    fare_class_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    parent_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 0,
    },
    cost => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 0,
    }
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    'timetable' => 'ClubSpain::Schema::Result::TimeTable', 'timetable_id'
);
__PACKAGE__->belongs_to(
    'fare_class' => 'ClubSpain::Schema::Result::FareClass', 'fare_class_id'
);
__PACKAGE__->might_have(
    'parent' => 'ClubSpain::Schema::Result::Itinerary', 'parent_id'
);
__PACKAGE__->has_many(
    'children' => 'ClubSpain::Schema::Result::Itinerary', {'foreign.parent_id' => 'self.id' }
);


#получение следующего маршрута
sub next_route {
    my $self = shift;

    return $self->children()->single();
}

#расчет стоимости перелета.
#стоимость перелета складывается из стоимости каждого сегмента
sub total {
    my $self = shift;

    my $route = $self->next_route();
    return $self->cost unless $route;
    return $self->cost + $route->total();
}

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_parent', fields => ['parent_id']);
    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);

}

1;
