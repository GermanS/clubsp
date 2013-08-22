package ClubSpain::Schema::Result::Article;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'article' );
__PACKAGE__ -> source_name( 'Article' );

__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    parent_id => {
        data_type   => 'integer',
        is_nullable => 0,
    },
    weight => {
        data_type   => 'integer',
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
    header => {
        data_type   => 'varchar',
        size        => 254,
        is_nullable => 0
    },
    subheader => {
        data_type   => 'varchar',
        size        => 254,
        is_nullable => 0
    },
    body => {
        data_type => 'text',
    }
);

__PACKAGE__ -> set_primary_key( 'id' );

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Article

=head1 DESCRIPTION

Модель таблицы article - статья

=head1 FIELDS

=head2 id

Идентфикатор статьи

=head2 parent_id

Идентификатор родительской статьи

=head2 weight

Вес статьи, для сортировки на результирующей странице или списке

=head2 is_published

Флаг опубликованонности стать на сайте
true  - статья опубликована
false - статья скрыта

=head2 header

Заголовок статьи

=head2 subheader

Подзаголовок статьи

=head body

Тело статьи

=head1 SEE ALSO

L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut