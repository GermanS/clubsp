package ClubSpain::Form::BackOffice::Flight;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::FlightRole',
         'ClubSpain::Form::BackOffice::Field::Airline';

has 'model_object' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::Flight',
    required => 0,
);

has '+name' => ( default => 'flight' );

has_field 'CountryOfDeparture' => ( type => 'Hidden' );
has_field 'CityOfDeparture'    => ( type => 'Hidden' );
has_field 'AirportOfDeparture' => ( type => 'Hidden', required => 1 );
has_field 'CountryOfArrival'   => ( type => 'Hidden' );
has_field 'CityOfArrival'      => ( type => 'Hidden' );
has_field 'AirportOfArrival'   => ( type => 'Hidden', required => 1 );

has_field 'airline_id' => (
    element_class => ['span8'],
    label         => 'Авиакомпания',
    required      => 1,
    type          => 'Select'
);

has_field 'code' => (
    element_class => ['span1'],
    label         => 'Номер рейса (3-4 цифры)',
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

    $self->model_object->departure_airport_id($self->field('AirportOfDeparture')->value);
    $self->model_object->destination_airport_id($self->field('AirportOfArrival')->value);
    $self->model_object->airline_id($self->field('airline_id')->value);
    $self->model_object->code($self->field('code')->value);
};

no HTML::FormHandler::Moose;

1;
