package ClubSpain::Form::BackOffice::Terminal;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Terminal',
     'ClubSpain::Form::BackOffice::Field::Airport';

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

sub get_name { shift->field('name')->value; }
sub set_name { shift->field('name')->value(@_); }
sub get_airport_id { shift->field('airport_id')->value; }
sub set_airport_id { shift->filed('airport_id')->value(@_); }

sub validate_airport_id {
    my ($self, $field) = @_;
    $self->check_field('validate_airport_id', $field);
}
sub validate_name {
    my ($self, $field) = @_;
    $self->check_field('validate_name', $field);
}

no HTML::FormHandler::Moose;

1;
