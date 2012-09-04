package ClubSpain::Form::BackOffice::Article;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Article',
     'ClubSpain::Form::BackOffice::Field::Article';

has '+name' => ( default => 'article' );

has_field 'parent_id' => (
    element_class => ['span11'],
    label         => 'Раздел',
    required      => 0,
    type          => 'Select',
    empty_select  => '',
    value_when_empty => 0
);
has_field 'header' => (
    element_class => ['span11'],
    label         => 'Заголовок',
    required      => 1,
    type          => 'Text'
);
has_field 'subheader' => (
    element_class => ['span11'],
    label         => 'Подзаголовок',
    required      => 1,
    type          => 'Text'
);
has_field 'body' => (
    element_class => ['span11'],
    label         => 'Статья',
    required      => 1,
    type          => 'TextArea',
    rows          => 12
);

has_field 'form_actions' => ( type => 'Compound' );
has_field 'form_actions.save' => ( widget => 'ButtonTag', type => 'Submit', value => 'Сохранить');
has_field 'form_actions.cancel' => ( widget => 'ButtonTag', type => 'Reset', value => 'Отменить');

sub build_form_element_class { ['well'] };
sub build_update_subfields {{
    form_actions => { do_wrapper => 1, do_label => 0 },
    'form_actions.save' => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] },
    'form_actions.cancel' => { widget_wrapper => 'None', element_class => ['btn'] },
}};

#implement ClubSpain::Model::Role::Airport
sub parent_id  { shift->field('parent_id')->value(@_); }
sub header     { shift->field('header')->value(@_); }
sub subheader  { shift->field('subheader')->value(@_); }
sub body       { shift->field('body')->value(@_); }

sub validate_header {
    my ($self, $field) = @_;
    $self->check_field('validate_header', $field);
}
sub validate_subheader {
    my ($self, $field) = @_;
    $self->check_field('validate_subheader', $field);
}
sub validate_body {
    my ($self, $field) = @_;
    $self->check_field('validate_body', $field);
}

no HTML::FormHandler::Moose;

1;
