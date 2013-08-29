package ClubSpain::Schema::Result::Office;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'office' );
__PACKAGE__ -> source_name( 'Office' );
__PACKAGE__ -> add_columns(
    id          => { data_type => 'integer', is_auto_increment => 1 },
    company_id  => { data_type => 'integer', is_nullable => 0, is_foreign_key => 1 },
    zipcode     => { data_type => 'integer', size => 6,   is_nullable => 0 },
    street      => { data_type => 'varchar', size => 255, is_nullable => 0 },
    name        => { data_type => 'varchar', size => 255, is_nullable => 0 },
    is_published => {
        data_type     => 'TINYINT(1) UNSIGNED',
        is_nullable   => 0,
    },
);

__PACKAGE__ -> set_primary_key('id');
__PACKAGE__ -> belongs_to(
    'company' => 'ClubSpain::Schema::Result::Company', 'company_id'
);
__PACKAGE__ -> has_many(
    phones => 'ClubSpain::Schema::Result::LocalPhone',
    { 'foreign.office_id' => 'self.id' },
    { cascade_delete => 0 }
);
__PACKAGE__ -> has_many(
    operators => 'ClubSpain::Schema::Result::Operator',
    { 'foreign.office_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index(
        name => 'on_is_published',
        fields => ['is_published'],
    );
}

1;

__END__

=head1 NAME

ClubSpain::Schema::Result::Office

=head1 DESCRIPTION

Модель таблицы office - офис компании.

=head1 FIELDS

=head2 id

Идентфикатор офиса

=head2 company_id

Идентфикатор компании

=head2 zipcode

Почтовый индекс офиса

=head2 street

Адрес офиса

=head2 name

Название офиса

=head2 is_published

Флаг опубликованности офиса

=head1 METHODS

=head2 company()

Получение предприятия, в котором работает сотрудник

=head2 phones()

Получение списка телефонов офиса

=head2 operators()

Получение списка сотрудников офиса.

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Company>
L<ClubSpain::Schema::Result::LocalPhone>
L<ClubSpain::Schema::Result::Operator>
L<DBIx::Class>

=head1 AUTHOR

Germans Semenkov
german.semenkov@gmail.com

=cut
