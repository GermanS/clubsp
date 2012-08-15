package ClubSpain::Form::BackOffice::TimeTable;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::Field::Airplane';
#         'ClubSpain::Form::BackOffice::TimeTableRole';

has 'model_object' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::TimeTable',
    required => 0,
);

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

after 'validate' => sub {
    my $self = shift;
    return unless $self->is_valid();

    my %form2database = (
        flight_id       => 'Flight',
        airplane_id     => 'airplane_id',
        departure_date  => 'DateOfDeparture',
        departure_time  => 'TimeOfDeparture',
        arrival_date    => 'DateOfArrival',
        arrival_time    => 'TimeOfArrival'
    );

    while (my ($database, $form)  = each (%form2database)) {
        $self->model_object->$database(
            $self->field($form)->value
        );
    }
};

no HTML::FormHandler::Moose;

1;
