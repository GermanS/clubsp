package ClubSpain::Schema::Result::Country;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'country' );
__PACKAGE__ -> source_name( 'Country' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    name => {
        data_type   => 'char',
        size        => 254,
        is_nullable => 0,
    },
    alpha2 => {
        data_type   => 'char',
        size        => 2,
        is_nullable => 0,
    },
    alpha3 => {
        data_type   => 'char',
        size        => 3,
        is_nullable => 0,
    },
    numerics => {
        data_type   => 'tinyint unsigned',
        is_nullable => 1,
    },
    is_published => {
        data_type   => 'tinyint(1) unsigned',
        is_nullable => 1,
    }
);

__PACKAGE__ -> set_primary_key( 'id' );
__PACKAGE__ -> add_unique_constraint( on_name    => [ qw(name)] );
__PACKAGE__ -> add_unique_constraint( on_alpha2  => [ qw(alpha2)] );
__PACKAGE__ -> add_unique_constraint( on_alpha3  => [ qw(alpha3)] );
#__PACKAGE__ -> add_unique_constraint(on_numerics => [qw(numerics)]);

__PACKAGE__ -> has_many(
    cities => 'ClubSpain::Schema::Result::City',
    { 'foreign.country_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index( name => 'on_is_published', fields => [ 'is_published' ] );
}

sub to_hash {
    my $self = shift;

    return {
        id   => $self -> id,
        name => $self -> name
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Country

=head1 DESCRIPTION

Модель таблицы company - название страны.

=head1 FIELDS

=head2 id

Идентфикатор страны

=head2 name 

Название страны

=head2 alpha2 

2х буквенное обозначение страны

=head2 alpha3 

3х буквенное обозначение страны

=head2 numerics

Номер

=head2 is_published

Флаг опубликованности страны

=head1 INDEXES

=head2 on_name

Уникальный индекс на поле name

=head2 on_alpha2

Уникальный индекс на поле alpha2

=head2 on_alpha3

Уникальный индекс на полу alpha3

=head1 METHODS

=head2 cities

Получение списка городов страны

=head1 SEE ALSO

L<ClubSpain::Schema::Result::City>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut