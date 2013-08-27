package ClubSpain::Model::BankAccount;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'BankAccount' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'company_id' => (
    is      => 'rw',
    reader  => 'get_company_id',
    writer  => 'set_company_id',
);
has 'bank' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_bank',
    writer  => 'set_bank',
);
has 'BIC' => (
    is      => 'rw',
    isa     => 'BIC',
    reader  => 'get_BIC',
    writer  => 'set_BIC',
);
has 'current_account' => (
    is      => 'rw',
    isa     => 'Account',
    reader  => 'get_current_account',
    writer  => 'set_current_account',
);
has 'correspondent_account' => (
    is      => 'rw',
    isa     => 'Account',
    reader  => 'get_correspondent_account',
    writer  => 'set_correspondent_account',
);
has 'is_published' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 1,
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::BankAccount';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::BankAccount

=head1 SYNOPSIS

use ClubSpain::Model::BankAccount;
my $object = ClubSpain::Model::BankAccount -> new(
    company_id            => $company_id,
    bank                  => $bank,
    BIC                   => $bic,
    current_account       => $current_account,
    correspondent_account => $correspondent_account,
    is_published          => $is_published,
);

if( $object -> validate_bank() ) {  ... }
if( $object -> validate_BIC() ) { ... }
if( $object -> validate_company_id() ) { ... }
if( $object -> validate_current_account() ) { ... }
if( $object -> validate_correspondent_account() ) { ... }

my $res = $object -> create();
my $res = $object -> update();
my $res = $object -> delete();

=head1 DESCRIPTION

Банковский счет предприятия.

=head1 FIELDS

=head1 id

Идентификатор банковского реквизита компании

=head2 company_id

Идентификатор компании

=head2 bank

Название банка

=head2 BIC

БИК

=head2 current_account

Расчетный счет

=head2 correspondent_account

Корреспондентский счет

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Редактирование записи в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::BankAccount>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut