package ClubSpain::Model::Role::Article;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    parent_id
    header
    subheader
    body
    validate_header
    validate_subheader
    validate_body
);

sub notify {
    my ($self, $object) = @_;

    $self->parent_id($object->parent_id || 0);
    $self->header($object->header);
    $self->subheader($object->subheader);
    $self->body($object->body);
}

1;
