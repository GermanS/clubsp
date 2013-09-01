package ClubSpain::Schema::Result::Company;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'company' );
__PACKAGE__ -> source_name( 'Company' );
__PACKAGE__ -> add_columns(
    id      => { data_type => 'integer', is_auto_increment => 1 },
    zipcode => { data_type => 'integer', size => 6,   is_nullable => 0 },
    street  => { data_type => 'varchar', size => 255, is_nullable => 0 },
    name    => { data_type => 'varchar', size => 255, is_nullable => 0 },
    nick    => { data_type => 'varchar', size => 255, is_nullable => 0 },
    website => { data_type => 'varchar', size => 50,  is_nullable => 0 },
    INN     => { data_type => 'varchar', size => 12,  is_nullable => 0 },
    OKPO    => { data_type => 'varchar', size => 10,  is_nullable => 0 },
    OKVED   => { data_type => 'varchar', size => 50,  is_nullable => 0 },
    is_NDS => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
);

__PACKAGE__ -> set_primary_key('id');
__PACKAGE__ -> add_unique_constraint( on_INN => [ qw(INN) ] );

__PACKAGE__ -> has_many(
    bank_accounts => 'ClubSpain::Schema::Result::BankAccount',
    { 'foreign.company_id' => 'self.id' },
    { cascade_delete => 0 }
);
__PACKAGE__ -> has_many(
    offices => 'ClubSpain::Schema::Result::Office',
    { 'foreign.company_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $self -> SUPER::sqlt_deploy_hook( $sqlt_table );
    $sqlt_table -> add_index( name => 'on_is_published', fields => [ 'is_published' ] );
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Company

=head1 DESCRIPTION

Модель таблицы company - название предприятия.

=head1 FIELDS

=head2 id

Идентификатор компании

=head2 zipcode

Почтовый индекс

=head2 street

Адрес фирмы

=head2 name

Полное название компании

=head2 nick

Краткое название компании

=head2 website

Адвес страницы в интернете

=head2 INN

ИНН компании

=head2 OKPO

ОКПО

=head2 OKVED

ОКВЭД

=head2 is_NDS

Является ли компания платильником НДС.
true - да, является

=head2 is_published

Флаг опубликованности

=head1 INDEXES

=head2 on_INN

Уникальный индекс по полю inn

=head1 METHODS

=head2 bank_accounts

Получение списка банковских счетов оршанизации

=head2 offices

Получение списка офисов

=head1 SEE ALSO

L<ClubSpain::Schema::Result::BankAccount>
L<ClubSpain::Schema::Result::Office>
L<DBix::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut