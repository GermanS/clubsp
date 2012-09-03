package ClubSpain::Form::BackOffice::Country;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Country';

has '+name' => ( default => 'country' );

has_field 'country'  => (
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

#implement ClubSpain::Model::Role::Country
sub country  { shift->field('country')->value(@_); }
sub alpha2   { shift->field('alpha2')->value(@_); }
sub alpha3   { shift->field('alpha3')->value(@_); }
sub numerics { shift->field('numerics')->value(@_); }

sub validate_country {
    my ($self, $field) = @_;
    $self->check_field('validate_country', $field);
}
sub validate_alpha2 {
    my ($self, $field) = @_;
    $self->check_field('validate_alpha2', $field);
}
sub validate_alpha3 {
    my ($self, $field) = @_;
    $self->check_field('validate_alpha3', $field);
}
sub validate_numerics {
    my ($self, $field) = @_;
    $self->check_field('validate_numerics', $field);
}

no HTML::FormHandler::Moose;

1;
