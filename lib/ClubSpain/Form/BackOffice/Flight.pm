package ClubSpain::Form::BackOffice::Flight;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Flight',
     'ClubSpain::Form::BackOffice::Field::Airline';

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

sub get_airport_of_departure { shift->field('AirportOfDeparture')->value; }
sub set_airport_of_departure { shift->field('AirportOfDeparture')->value(@_); }
sub get_airport_of_arrival { shift->field('AirportOfArrival')->value; }
sub set_airport_of_arrival { shift->field('AirportOfArrival')->value(@_); }
sub get_airline_id { shift->field('airline_id')->value; }
sub set_airline_id { shift->field('airline_id')->value(@_); }
sub get_code { shift->field('code')->value; }
sub set_code { shift->field('code')->value(@_); }

sub validate_airport_of_departure {
    my ($self, $field) = @_;
    $self->check_field('validate_airport_of_departure', $field);
}
sub validate_airport_of_arrival  {
    my ($self, $field) = @_;
    $self->check_field('validate_airport_of_arrival', $field);
}
sub validate_airline_id {
    my ($self, $field) = @_;
    $self->check_field('validate_airline_id', $field);
}
sub validate_code {
    my ($self, $field) = @_;
    $self->check_field('validate_code', $field);
}

no HTML::FormHandler::Moose;

1;
