package ClubSpain::Model::BankAccount;
use Moose;
use namespace::autoclean;
use utf8;
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

sub validate_bank {}
sub validate_BIC {}
sub validate_company_id {}
sub validate_current_account {}
sub validate_correspondent_account {}

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        company_id      => $self->get_company_id,
        bank            => $self->get_bank,
        BIC             => $self->get_BIC,
        current_account => $self->get_current_account,
        correspondent_account => $self->get_correspondent_account,
        is_published    => $self->get_is_published,

    };
}

__PACKAGE__->meta->make_immutable;

1;
