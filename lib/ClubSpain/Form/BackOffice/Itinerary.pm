package ClubSpain::Form::BackOffice::Itinerary;
use strict;
use warnings;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::Field::FareClass';

has 'model_object' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::Itinerary',
    required => 0,
);

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

after 'validate' => sub {
    my $self = shift;
    return unless $self->is_valid();

    $self->model_object->timetable_id(
        $self->field('Flight1')->value
    );
    $self->model_object->return_segment(
        $self->field('Flight2')->value
    );
    $self->model_object->fare_class_id(
        $self->field('fare_class_id')->value
    );
    $self->model_object->cost(
        $self->field('cost')->value
    );
};

no HTML::FormHandler::Moose;

1;
