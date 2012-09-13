package ClubSpain::Schema::Result::BankAccount;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);

__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('bank_account');
__PACKAGE__->source_name('BankAccount');
__PACKAGE__->add_columns(
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

__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to(
    'company' => 'ClubSpain::Schema::Result::Company', 'company_id'
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
