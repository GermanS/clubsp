package ClubSpain::Schema::Result::Customer;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'customer' );
__PACKAGE__ -> source_name( 'Customer' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    name => {
        data_type   => 'varchar',
        size        => 50,
        is_nullable => 0,
    },
    surname => {
        data_type   => 'varchar',
        size        => 50,
        is_nullable => 0,
    },
    email => {
        data_type   => 'varchar',
        size        => 50,
        is_nullable => 0,
    },
    passwd => {
        data_type   => 'varchar',
        size        => 64,
        is_nullable => 0,
    },
    mobile => {
        data_type   => 'BIGINT unsigned',
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'tinyint(1) unsigned',
        is_nullable => 0,
    },
);

__PACKAGE__ -> set_primary_key( 'id' );
__PACKAGE__ -> add_unique_constraint( on_email => [ qw(email) ] );

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index( 
        name   => 'on_is_published', 
        fields => [ 'is_published' ] 
    );
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Customer

=head1 DESCRIPTION

Модель таблицы customer - пользователь сайта.

=head1 FIELDS

=head2 id 

Идентификатор пользователя

=head2 name 

Имя пользователя

=head2 surname

Фамилия пользователя

=head2 email

Адрес электронной почты

=head2 passwd

Пароль

=head2 mobile

Номер мобильного телефона

=head2 is_published 

Флаг опубликованности

=head1 INDEXES

=head2 on_email

Уникальный индекс на поле email

=head1 SEE ALSO

L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut