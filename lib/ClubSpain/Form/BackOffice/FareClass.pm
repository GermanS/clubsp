package ClubSpain::Form::BackOffice::FareClass;
use strict;
use warnings;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';
    with 'ClubSpain::Form::BackOffice::FareClassRole';

has 'fareclass' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::FareClass',
    required => 0,
);

has '+name' => ( default => 'fare_class' );

has_field 'name' => (
    element_class => ['span11'],
    label         => 'Название класса',
    required      => 1,
    type          => 'Text'
);

has_field 'code' => (
    element_class => ['span1'],
    label         => 'Код (1 буква)',
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

    $self->fareclass->name($self->field('name')->value);
    $self->fareclass->code($self->field('code')->value);
};

no HTML::FormHandler::Moose;

1;
