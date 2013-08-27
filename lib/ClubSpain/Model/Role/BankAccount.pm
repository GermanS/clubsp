package ClubSpain::Model::Role::BankAccount;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_company_id
    set_company_id
    get_bank
    set_bank
    get_BIC
    set_BIC
    get_current_account
    set_current_account
    get_correspondent_account
    set_correspondent_account
);

#TODO: (german) удалить это в будующем. Использовать пакет Business::RU
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

sub validate_bank {}
sub validate_BIC {}
sub validate_company_id {}
sub validate_current_account {}
sub validate_correspondent_account {}

sub params {
    my $self = shift;

    return {
        company_id            => $self -> get_company_id(),
        bank                  => $self -> get_bank(),
        BIC                   => $self -> get_BIC(),
        current_account       => $self -> get_current_account(),
        correspondent_account => $self -> get_correspondent_account(),
        is_published          => $self -> get_is_published(),

    };
}

1;

__END__

=head1 NAME

ClubSpain::Model::Role::BankAccount

=head1 DESCRIPTION

Интерфейсные методы для банковких реквизитов компании

=head1 METHODS

=head2 validate_bank()

Проверка названия банка

=head2 validate_BIC()

Проверка БИКа

=head2 validate_company_id()

Проверка идентфикатора компании

=head2 validate_current_account()

Проверка расчетного счета

=head2 validate_correspondent_account()

Проверка корреспондентского счета

=head2 params()

#TODO: сделать описание

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut