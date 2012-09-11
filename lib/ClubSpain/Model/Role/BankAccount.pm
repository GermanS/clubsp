package ClubSpain::Model::Role::BankAccount;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_company_id
    set_company_id
    validate_company_id
    get_bank
    set_bank
    validate_bank
    get_BIC
    set_BIC
    validate_BIC
    get_current_account
    set_current_account
    validate_current_account
    get_correspondent_account
    set_correspondent_account
    validate_correspondent_account
);

sub _validate_account {
    my ($self, $account) = @_;

    my @weights = qw(7 1 3 7 1 3 7 1 3 7 1 3 7 1 3 7 1 3 7 1 3 7 1);
    my $result = 0;
    for (my $i = 0; $i < 23; $i++) {
        $result += substr($account, $i, 1) * $weights[$i];
    }

    $result % 10 == 0;
}

#проверка расчетного счета
#вычисляется контрольная сумма расчетного счета и БИК
sub check_current_account {
    my $self = shift;

    $self->_validate_account(
        sprintf "%s%s", substr($self->get_bic, 6, 3), $self->get_current_account
    );
}
#проверка корреспондентского счета
#вычисляется контрольная сумма корреспондентского счета и БИК
sub check_correspondent_account {
    my $self = shift;

    $self->_validate_account(
        sprintf "0%s%s", substr($self->get_BIC, 4, 2), $self->get_correspondent_account
    );
}




1;
