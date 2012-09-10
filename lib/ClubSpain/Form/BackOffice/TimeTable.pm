package ClubSpain::Form::BackOffice::TimeTable;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::TimeTable',
     'ClubSpain::Form::BackOffice::Field::Airplane';

has '+name' => ( default => 'flight' );

has_field 'CityOfDeparture' => ( type => 'Hidden' );
has_field 'CityOfArrival'   => ( type => 'Hidden' );
has_field 'Flight'          => ( type => 'Hidden', required => 1 );

has_field 'airplane_id' => (
    element_class => ['span6'],
    label         => 'Марка самолета',
    required      => 1,
    type          => 'Select'
);

has_field 'DateOfDeparture' => (
    element_class => ['small'],
    label         => 'Дата отправления (ГГГГ-ММ-ДД)',
    required      => 1,
    type          => 'Text'
);

has_field 'TimeOfDeparture' => (
    element_class => ['mini'],
    label         => 'Время отправления (ЧЧ:ММ)',
    required      => 1,
    type          => 'Text'
);

has_field 'DateOfArrival' => (
    element_class => ['small'],
    label         => 'Дата прибытия (ГГГГ-ММ-ДД)',
    required      => 1,
    type          => 'Text'
);

has_field 'TimeOfArrival' => (
    element_class => ['mini'],
    label         => 'Время прибытия (ЧЧ:ММ)',
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

sub get_flight_id { shift->field('Flight')->value; }
sub set_flight_id { shift->field('Flight')->value(@_); }
sub get_airplane_id { shift->field('airplane_id')->value; }
sub set_airplane_id { shift->field('airplane_id')->value(@_); }
sub get_departure_date { shift->field('DateOfDeparture')->value; }
sub set_departure_date { shift->field('DateOfDeparture')->value(@_); }
sub get_departure_time { shift->field('TimeOfDeparture')->value; }
sub set_departure_time { shift->field('TimeOfDeparture')->value(@_); }
sub get_arrival_date { shift->field('DateOfArrival')->value; }
sub set_arrival_date { shift->field('DateOfArrival')->value(@_); }
sub get_arrival_time { shift->field('TimeOfArrival')->value; }
sub set_arrival_time { shift->field('TimeOfArrival')->value(@_); }

sub validate_Flight { shift->validate_flight_id(shift); }
sub validate_flight_id {
    my ($self, $field) = @_;
    $self->check_field('validate_flight_id', $field);
}
sub validate_airplane_id {
    my ($self, $field) = @_;
    $self->check_field('validate_airplane_id', $field);
}
sub validate_DateOfDeparture { shift->validate_departure_date(@_); };
sub validate_departure_date {
    my ($self, $field) = @_;
    $self->check_field('validate_departure_date', $field);
};

sub validate_TimeOfDeparture { shift->validate_departure_time(@_); }
sub validate_departure_time {
    my ($self, $field) = @_;
    $self->check_field('validate_departure_time', $field);
};

sub validate_DateOfArrival { shift->validate_arrival_date(@_); }
sub validate_arrival_date {
    my ($self, $field) = @_;
    $self->check_field('validate_arrival_date', $field);
};

sub validate_TimeOfArrival { shift->validate_arrival_time(@_); }
sub validate_arrival_time {
    my ($self, $field) = @_;
    $self->check_field('validate_arrival_time', $field);
};

no HTML::FormHandler::Moose;

1;
