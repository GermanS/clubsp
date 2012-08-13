package ClubSpain::Form::BackOffice::Employee;
use strict;
use warnings;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';

has 'model_object' => (
    is       => 'rw',
    isa      => 'ClubSpain::Model::Employee',
    required => 0,
);

has '+name' => ( default => 'employee' );

has_field 'name' => (
    element_class => ['span11'],
    label         => 'Имя сотрудника',
    required      => 1,
    type          => 'Text'
);
has_field 'surname' => (
    element_class => ['span11'],
    label         => 'Фамилия сотрудника',
    required      => 1,
    type          => 'Text'
);
has_field 'email' => (
    element_class => ['span11'],
    label         => 'Адрес электронной почты',
    required      => 1,
    type          => 'Text'
);
has_field 'password' => (
    element_class => ['span2'],
    label         => 'Пароль',
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

    $self->model_object->name(
        $self->field('name')->value
    );
    $self->model_object->surname(
        $self->field('surname')->value
    );
    $self->model_object->email(
        $self->field('email')->value
    );
    $self->model_object->password(
        $self->field('password')->value
    );
};

no HTML::FormHandler::Moose;

1;
