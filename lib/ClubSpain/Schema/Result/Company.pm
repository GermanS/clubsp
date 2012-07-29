package ClubSpain::Schema::Result::Company;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('company');
__PACKAGE__->source_name('Company');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    name  => { data_type => 'varchar', size => 50, is_nullable => 0 },
    nick  => { data_type => 'varchar', size => 50, is_nullable => 0 },
    INN   => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OGRN  => { data_type => 'varchar', size => 50, is_nullable => 0 },
    KPP   => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKPO  => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKVED => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKATO => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKTMO => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKOGU => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKFS  => { data_type => 'varchar', size => 50, is_nullable => 0 },
    OKPF  => { data_type => 'varchar', size => 50, is_nullable => 0 },
    is_published => {
        data_type     => 'TINYINT(1) UNSIGNED',
        is_nullable   => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_email => [qw(INN)]);


sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'on_is_published', fields => ['is_published']);
}

1;