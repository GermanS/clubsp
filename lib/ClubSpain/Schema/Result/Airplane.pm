package ClubSpain::Schema::Result::Airplane;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'airplane' );
__PACKAGE__ -> source_name( 'Airplane' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    manufacturer_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    iata => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    icao => {
        data_type     => 'char',
        size          => 4,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 254,
        is_nullable   => 0
    },
    is_published => {
        data_type     => 'TINYINT(1) UNSIGNED',
        is_nullable   => 1,
    }
);

__PACKAGE__ -> set_primary_key( 'id' );
__PACKAGE__ -> add_unique_constraint( on_manufacturer_id_name => [ qw(manufacturer_id name) ] );

__PACKAGE__ -> belongs_to(
    'manufacturer' => 'ClubSpain::Schema::Result::Manufacturer', 'manufacturer_id'
);
__PACKAGE__ -> has_many(
    time_tables => 'ClubSpain::Schema::Result::TimeTable',
    { 'foreign.airplane_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $self -> SUPER::sqlt_deploy_hook( $sqlt_table );
    $sqlt_table -> add_index( name => 'on_is_published', fields => [ 'is_published' ] );
}

sub to_hash {
    my $self = shift;

    return {
        id   => $self -> id,
        code => $self -> iata,
        name => $self -> name,
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Airplane

=head1 DESCRIPTION

Модель таблицы airplane - марка самолета

=head1 FIELDS

=head2 id

Идентификатор марки самолета.

=head2 manufacturer_id

Идентфикатор производителя самолета.

=head2 iata

IATA код марки самолета

=head2 icao

ICAO код марки самолета

=head2 name

Название самолета

=head2 is_published

Флаг "опубликованности" модели самолета на сайте.
true  - опубликован
false - скрыт

=head1 INDEXES

=head2 on_manufacturer_id_name

Уникальный индекс на поля manufacturer_id и name

=head1 METHODS

=head2 manufacturer()

Получение производителя данной марки самолета

=head2 time_tables

Получение списка расписаний для данной марки самолета.

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Manufacturer>
L<ClubSpain::Schema::Result::TimeTable>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut