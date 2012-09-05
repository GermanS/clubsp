package ClubSpain::Form::BackOffice::Airline;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Airline';

has '+name' => ( default => 'airline' );

has_field 'name' => (
    element_class => ['span11'],
    label         => 'Название авиакомпании',
    required      => 1,
    type          => 'Text'
);

has_field 'iata' => (
    element_class => ['span1'],
    label         => 'Код IATA (2 буквы)',
    required      => 1,
    type          => 'Text',
);

has_field 'icao' => (
    element_class => ['span1'],
    label         => 'Код ICAO (3 буквы)',
    required      => 1,
    type          => 'Text',
);

has_field 'form_actions'
    => ( type => 'Compound' );
has_field 'form_actions.save'
    => ( widget => 'ButtonTag', type => 'Submit', value => 'Сохранить');
has_field 'form_actions.cancel'
    => ( widget => 'ButtonTag', type => 'Reset',  value => 'Отменить');

sub build_form_element_class { ['well'] }
sub build_update_subfields {{
    form_actions => { do_wrapper => 1, do_label => 0 },
    'form_actions.save' => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] },
    'form_actions.cancel' => { widget_wrapper => 'None', element_class => ['btn'] },
}}

#implement ClubSpain::Model::Role::Airline
sub get_name { shift->field('name')->value; }
sub set_name { shift->field('name')->value(@_); }
sub get_iata { shift->field('iata')->value; }
sub set_iata { shift->field('iata')->value(@_); }
sub get_icao { shift->field('icao')->value; }
sub set_icao { shift->field('icao')->value(@_); }

sub validate_name {
    my ($self, $field) = @_;
    $self->check_field('validate_name', $field);
}

sub validate_iata {
    my ($self, $field) = @_;
    $self->check_field('validate_iata', $field);
}

sub validate_icao {
    my ($self, $field) = @_;
    $self->check_field('validate_icao', $field);
}

no HTML::FormHandler::Moose;

1;
