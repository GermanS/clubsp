package ClubSpain::Schema::Result::Itinerary;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'itinerary' );
__PACKAGE__ -> source_name( 'Itinerary' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    is_published => {
        data_type     => 'TINYINT(1) UNSIGNED',
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
        default_value  => 0,
        is_foreign_key => 0,
    },
    cost => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 0,
    }
);

__PACKAGE__ -> set_primary_key('id');

__PACKAGE__ -> belongs_to(
    'timetable' => 'ClubSpain::Schema::Result::TimeTable', 'timetable_id'
);
__PACKAGE__ -> belongs_to(
    'fare_class' => 'ClubSpain::Schema::Result::FareClass', 'fare_class_id'
);
__PACKAGE__ -> might_have(
    'parent' => 'ClubSpain::Schema::Result::Itinerary', 'parent_id'
);
__PACKAGE__ -> has_many(
    'children' => 'ClubSpain::Schema::Result::Itinerary', {'foreign.parent_id' => 'self.id' }
);


#получение следующего маршрута
sub next_route {
    my $self = shift;

    return $self -> children() -> single();
}

#расчет стоимости перелета.
#стоимость перелета складывается из стоимости каждого сегмента
sub total {
    my $self = shift;

    my $route = $self -> next_route();
    return $self -> cost unless $route;
    return $self -> cost + $route -> total();
}

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index( name => 'on_parent', fields => ['parent_id'] );
    $sqlt_table -> add_index( name => 'on_is_published', fields => ['is_published'] );

}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Itinerary

=head1 DESCRIPTION

Модель таблицы itinerary - тариф на сегмент.

=head1 FIELDS

=head2 id

Идентификатор тарифа

=head2 is_published 

Флаг опубликованности сегмента

=head2 timetable_id 

Идентификатор расписания

=head2 fare_class_id

Идентификатор класса обслуживания

=head2 parent_id

Идентификатор родительского сегмента перелета

=head2 cost

Стоимость сегмента

=head1 METHODS

=head2 timetable()

Получение расписания сегмента.

=head2 fare_class()

Получение класса обслуживания.

=head2 parent()

ПОлучение списка предыдущих сегментов

=head2 children()

Получени списка следующих сегментов

=head2 next_route()

Получение следующего маршрута

=head2 total()

Расчет стоимости перелета.
Стоимость перелета складывается из стоимости каждого сегмента

=head1 SEE ALSO

L<ClubSpain::Schema::Result::TimeTable>
L<ClubSpain::Schema::Result::FareClass>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut