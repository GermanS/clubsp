package ClubSpain::Schema::Result::LocalPhone;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'local_phone' );
__PACKAGE__ -> source_name( 'LocalPhone' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    office_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    number => {
        data_type   => 'BIGINT UNSIGNED',
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
);

__PACKAGE__ -> set_primary_key('id');
__PACKAGE__ -> belongs_to(
    'office' => 'ClubSpain::Schema::Result::Office', 'office_id'
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index( 
        name => 'on_is_published', 
        fields => ['is_published'] 
    );
}

1;

__END__

=head1 NAME

ClubSpain::Schema::Result::LocalPhone

=head1 DESCRIPTION

Модель таблицы local_phone - номер телефона.

=head1 FIELDS

=head2 id 

Идентфикатор телефона

=head2 office_id

Идентификатор офиса

=head2 number 

Номер телефона

=head2 is_published 

Флаш опубликованности номера телефона

=head1 METHODS

=head2 office()

Получение офиса, котором принадлежит телефон

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Office>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut
