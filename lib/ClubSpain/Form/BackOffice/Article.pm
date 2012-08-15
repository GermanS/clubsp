package ClubSpain::Form::BackOffice::Article;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::Field::Article';

has 'model_object' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::Article',
    required => 0,
);

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

after 'validate' => sub {
    my $self = shift;
    return unless $self->is_valid();

    $self->model_object->parent_id(
        $self->field('parent_id')->value || 0
    );
    $self->model_object->header(
        $self->field('header')->value
    );
    $self->model_object->subheader(
        $self->field('subheader')->value
    );
    $self->model_object->body(
        $self->field('body')->value
    );
};

no HTML::FormHandler::Moose;

1;
