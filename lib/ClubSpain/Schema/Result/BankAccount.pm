package ClubSpain::Schema::Result::BankAccount;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table( 'bank_account' );
__PACKAGE__ -> source_name( 'BankAccount' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    company_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    bank => {
        data_type   => 'varchar',
        size        => 255,
        is_nullable => 0,
    },
    BIC => {
        data_type   => 'char',
        size        => 9,
        is_nullable => 0,
    },
    current_account => {
        data_type   => 'char',
        size        => 20,
        is_nullable => 0,
    },
    correspondent_account => {
        data_type   => 'char',
        size        => 20,
        is_nullable => 0,
    },
    is_published => {
        data_type    => 'TINYINT(1) UNSIGNED',
        is_nullable  => 0,
    },
);

__PACKAGE__ -> set_primary_key( 'id' );
__PACKAGE__ -> belongs_to(
    'company' => 'ClubSpain::Schema::Result::Company', 'company_id'
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
=head1 DESCRIPTION
=head1 FIELDS

=head2 id

Идентификатор

=head2 company_id

Идентфикатор компании

=head2 bank

Название банка

=head2 BIC

БИК

=head2 current_account

Номер расчетного счета

=head2 correspondent_account

Номер корреспондентского счета

=head2 is_published

Флаг активности/доступности
true - активен/доступен

=head1 METHODS

=head2 company

Поучение компании, которой принадлежит банковский счет.

=head1 SEE ALSO

L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut