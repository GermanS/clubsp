package ClubSpain::Schema::Result::City;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'city' );
__PACKAGE__ -> source_name( 'City' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    country_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    iata => {
        data_type   => 'char',
        size        => 3,
        is_nullable => 0,
    },
    name => {
        data_type   => 'char',
        size        => 254,
        is_nullable => 0,
    },
    name_ru => {
        data_type   => 'char',
        size        => 254,
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 1,
    }
);

__PACKAGE__ -> set_primary_key( 'id' );
__PACKAGE__ -> add_unique_constraint( on_iata => [ qw(iata) ] );
__PACKAGE__ -> add_unique_constraint( on_country_id_name => [ qw(country_id name) ] );


__PACKAGE__->belongs_to(
    'country' => 'ClubSpain::Schema::Result::Country', 'country_id'
);
__PACKAGE__->has_many(
    airports => 'ClubSpain::Schema::Result::Airport',
    { 'foreign.city_id' => 'self.id' },
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
        name => $self -> name,
        iata => $self -> iata
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::City

=head1 DESCRIPTION

Модель таблицы city - название города.

=head1 FIELDS

=head2 id

Идентификатор города

=head2 country_id

Идентфикатор страны

=head2 iata

IATA код города

=head2 name

Название города на латинском

=head2 name_ru

Название города на русском

=head2 is_published

Флаг опубликованности города.

=head1 INDEXES

=head2 on_iata

Уникальный индекс по полю iata

=head2 on_country_id_name

Уникальный индекс по полям country_id и name

=head1 METHODS

=head2 country

Получение страны

=head2 airports

Получение списка аэропортов города

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Country>
L<ClubSpain::Schema::Result::Airport>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut