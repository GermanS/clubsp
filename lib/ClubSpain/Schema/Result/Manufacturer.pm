package ClubSpain::Schema::Result::Manufacturer;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'manufacturer' );
__PACKAGE__ -> source_name( 'Manufacturer' );
__PACKAGE__ -> add_columns(
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

__PACKAGE__ -> set_primary_key('id');
__PACKAGE__ -> add_unique_constraint(on_code => [qw(code)]);

__PACKAGE__ -> has_many(
    'planes' => 'ClubSpain::Schema::Result::Airplane',
    {'foreign.manufacturer_id' => 'self.id' },
    { cascade_delete => 0 }
);

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Manufacturer

=head1 DESCRIPTION

Модель таблицы manufacturer - название производителя самолетов.

=head1 FIELDS

=head2 id

Идентфикатор производителя

=head2 code

Условное обозначение

=head2 name

Название

=head1 INDEXES

=head2 on_code

=head1 METHODS

=head2 planes()

Получение списка моделей самолетов данного производителя

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Airplane>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut