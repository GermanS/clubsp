package ClubSpain::Schema::Result::Office;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('office');
__PACKAGE__->source_name('Office');
__PACKAGE__->add_columns(
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

__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to(
    'company' => 'ClubSpain::Schema::Result::Company', 'company_id'
);
#__PACKAGE__->has_many(
#    bank_accounts => 'ClubSpain::Schema::Result::BankAccount',
#    { 'foreign.company_id' => 'self.id' },
#    { cascade_delete => 0 }
#);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;
