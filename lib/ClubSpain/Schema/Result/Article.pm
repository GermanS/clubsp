package ClubSpain::Schema::Result::Article;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(ForceUTF8 Core PK::Auto));
__PACKAGE__->table('article');
__PACKAGE__->source_name('Article');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    parent_id => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
    weight => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
    is_published => {
        data_type      => 'integer',
        is_nullable    => 0,
    },
    header => {
        data_type     => 'varchar',
        size          => 254,
        is_nullable   => 0
    },
    subheader => {
        data_type     => 'varchar',
        size          => 254,
        is_nullable   => 0
    },
    body => {
        data_type     => 'text',
    }
);

__PACKAGE__->set_primary_key('id');

1;
