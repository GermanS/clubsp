package ClubSpain::Form::BackOffice::City;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::City',
     'ClubSpain::Form::BackOffice::Field::Country';

has '+name' => ( default => 'city' );

has_field 'country_id' => (
    element_class => ['span9'],
    label         => 'Страна',
    required      => 1,
    type          => 'Select'
);

has_field 'name_en' => (
    element_class => ['span9'],
    label         => 'Город (латиницей)',
    required      => 1,
    type          => 'Text'
);

has_field 'name_ru' => (
    element_class => ['span9'],
    label         => 'Город (кириллицей)',
    required      => 1,
    type          => 'Text'
);

has_field 'iata' => (
    element_class => ['span1'],
    label         => 'Код IATA',
    required      => 1,
    type          => 'Text',
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

sub country_id { shift->field('country_id')->value(@_); }
sub iata       { shift->field('iata')->value(@_); }
sub name_en    { shift->field('name_en')->value(@_); }
sub name_ru    { shift->field('name_ru')->value(@_); }

sub validate_country_id {
    my ($self, $field) = @_;
    $self->check_field('validate_country_id', $field);
}
sub validate_iata {
    my ($self, $field) = @_;
    $self->check_field('validate_iata', $field);
}
sub validate_name_en {
    my ($self, $field) = @_;
    $self->check_field('validate_name_en', $field);
}
sub validate_name_ru {
    my ($self, $field) = @_;
    $self->check_field('validate_name_ru', $field);
}

no HTML::FormHandler::Moose;

1;
