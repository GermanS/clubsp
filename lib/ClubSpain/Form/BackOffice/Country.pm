package ClubSpain::Form::BackOffice::Country;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::CountryRole';

has 'country' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::Country',
    required => 0,
);

has '+name' => ( default => 'country' );

has_field 'name' => (
    element_class => ['span11'],
    label         => 'Название страны',
    required      => 1,
    type          => 'Text'
);

has_field 'alpha2' => (
    element_class => ['span1'],
    label         => '2х-буквенное название',
    required      => 1,
    type          => 'Text',
);

has_field 'alpha3' => (
    element_class => ['span1'],
    label         => '3х-буквенное название',
    required      => 1,
    type          => 'Text',
);

has_field 'numerics' => (
    element_class => ['span1'],
    label         => 'Код страны',
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

after 'validate' => sub {
    my $self = shift;
    return unless $self->is_valid();

    $self->country->name($self->field('name')->value);
    $self->country->alpha2($self->field('alpha2')->value);
    $self->country->alpha3($self->field('alpha3')->value);
    $self->country->numerics($self->field('numerics')->value);
};

no HTML::FormHandler::Moose;

1;
