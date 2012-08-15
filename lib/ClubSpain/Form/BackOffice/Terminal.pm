package ClubSpain::Form::BackOffice::Terminal;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::TerminalRole',
         'ClubSpain::Form::BackOffice::Field::Airport';

has 'model_object' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::Terminal',
    required => 0,
);

has '+name' => ( default => 'terminal' );

has_field 'airport_id' => (
    element_class => ['span11'],
    label         => 'Аэропорт',
    required      => 1,
    type          => 'Select'
);

has_field 'name' => (
    element_class => ['span11'],
    label         => 'Название терминала',
    required      => 1,
    type          => 'Text'
);

has_field 'form_actions' => ( type => 'Compound' );
has_field 'form_actions.save' => ( widget => 'ButtonTag', type => 'Submit', value => 'Сохранить');
has_field 'form_actions.cancel' => ( widget => 'ButtonTag', type => 'Reset', value => 'Отменить');

sub build_form_element_class { ['well'] }
sub build_update_subfields {{
    form_actions => { do_wrapper => 1, do_label => 0 },
    'form_actions.save' => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] },
    'form_actions.cancel' => { widget_wrapper => 'None', element_class => ['btn'] },
}}

after 'validate' => sub {
    my $self = shift;
    return unless $self->is_valid();

    $self->model_object->airport_id($self->field('airport_id')->value);
    $self->model_object->name($self->field('name')->value);
};

no HTML::FormHandler::Moose;

1;
