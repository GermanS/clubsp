package ClubSpain::Form::BackOffice::Airplane;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Airplane',
     'ClubSpain::Form::BackOffice::Field::Manufacturer';

has '+name' => ( default => 'airplane' );

has_field 'manufacturer_id' => (
    element_class => ['span11'],
    label         => 'Производитель',
    required      => 1,
    type          => 'Select',
);

has_field 'airplane' => (
    element_class => ['span11'],
    label         => 'Название марки самолета',
    required      => 1,
    type          => 'Text'
);

has_field 'iata' => (
    element_class => ['span1'],
    label         => 'Код IATA',
    required      => 1,
    type          => 'Text',
);

has_field 'icao' => (
    element_class => ['span1'],
    label         => 'Код ICAO',
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
    'form_actions.save'   => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] },
    'form_actions.cancel' => { widget_wrapper => 'None', element_class => ['btn'] },
}}

#implement ClubSpain::Model::Role::Airplane
sub manufacturer_id { shift->field('manufacturer_id')->value(@_); }
sub airplane { shift->field('airplane')->value(@_); }
sub iata     { shift->field('iata')->value(@_); }
sub icao     { shift->field('icao')->value(@_); }

sub validate_airplane {
    my ($self, $field) = @_;
    $self->check_field('validate_airplane', $field);
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
