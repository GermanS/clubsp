package ClubSpain::Form::BackOffice::Itinerary;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Itinerary',
     'ClubSpain::Form::BackOffice::Field::FareClass';

has '+name' => ( default => 'itinerary' );

has_field 'Flight1' => ( type => 'Hidden' );
has_field 'Flight2' => ( type => 'Hidden' );

has_field 'fare_class_id' => (
    element_class => ['span11'],
    label         => 'Класс',
    required      => 1,
    type          => 'Select'
);

has_field 'cost' => (
    element_class => ['span1'],
    label         => 'Стоимость',
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

#TODO: !!!
sub get_timetable_id { shift->field('Flight1')->value; }
sub set_timetable_id { shift->field('Flight1')->value(@_); }
sub get_return_segment { shift->field('Flight2')->value; }
sub set_return_segment { shift->field('Flight2')->value(@_); }
sub get_fare_class_id { shift->field('fare_class_id')->value; }
sub set_fare_class_id { shift->field('fare_class_id')->value(@_); }
sub get_cost { shift->field('cost')->value; }
sub set_cost { shift->field('cost')->value; }

#!!! идентификатор первого расписания
sub validate_timetable_id {
    my ($self, $field) = @_;
    $self->check_field('validate_timetable_id', $field);
}
#!!! идентифкатор второго расписания
sub validate_return_segment {
    my ($self, $field) = @_;
    $self->check_field('validate_return_segment', $field);
}
sub validate_fare_class_id {
    my ($self, $field) = @_;
    $self->check_field('validate_fare_class_id', $field);
}
sub validate_cost {
    my ($self, $field) = @_;
    $self->check_field('validate_cost', $field);
}

no HTML::FormHandler::Moose;

1;
