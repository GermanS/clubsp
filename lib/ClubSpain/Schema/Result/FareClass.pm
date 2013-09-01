package ClubSpain::Schema::Result::FareClass;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);


__PACKAGE__ -> table( 'fare_class' );
__PACKAGE__ -> source_name( 'FareClass' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    code => {
        data_type   => 'char',
        size        => 1,
        is_nullable => 0,
    },
    name => {
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
__PACKAGE__ -> add_unique_constraint( on_code => [ qw(code) ] );
__PACKAGE__ -> has_many(
    'itineraries' => 'ClubSpain::Schema::Result::Itinerary',
    { 'foreign.fare_class_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $self -> SUPER::sqlt_deploy_hook( $sqlt_table );
    $sqlt_table -> add_index(
        name => 'on_is_published',
        fields => ['is_published']
    );
}

sub to_hash {
    my $self = shift;

    return {
        id   => $self -> id,
        code => $self -> code,
        name => $self -> name,
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::FareClass

=head1 DESCRIPTION

Модель таблицы fare_class - класс обслуживания.

=head1 FIELDS

=head2 id

Идентификатор класса обслуживания

=head2 code

Условное обозначение класса обслуживания

=head2 name

Название класса обслуживания

=head2 is_published

Флаг опубликованности класса обслуживания.

=head1 INDEXES

=head2 on_code

Уникальный индекс по полю code

=head1 METHODS

=head2 itineraries()

Получение списка тарифов для данного класса обслуживания

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Itinerary>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut