package ClubSpain::Model::Role::Article;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_parent_id   set_parent_id   validate_parent_id
    get_header      set_header      validate_header
    get_subheader   set_subheader   validate_subheader
    get_body        set_body        validate_body
);

sub notify {
    my ($self, $object) = @_;
    $self->set_parent_id($object->get_parent_id || 0);
    $self->set_header($object->get_header);
    $self->set_subheader($object->get_subheader);
    $self->set_body($object->get_body);
}

1;
