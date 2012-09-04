package ClubSpain::Form::BackOffice::Employee;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Employee';


has '+name' => ( default => 'employee' );

has_field 'first_name' => (
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

sub first_name { shift->field('first_name')->value(@_); }
sub surname    { shift->field('surname')->value(@_); }
sub email      { shift->field('email')->value(@_); }
sub password   { shift->field('password')->value(@_); }

sub validate_first_name {
    my ($self, $field) = @_;
    $self->check_field('validate_first_name', $field);
}
sub validate_surname {
    my ($self, $field) = @_;
    $self->check_field('validate_surname', $field);
}
sub validate_email {
    my ($self, $field) = @_;
    $self->check_field('validate_email', $field);
}
sub validate_password {
    my ($self, $field) = @_;
    $self->check_field('validate_password', $field);
}

no HTML::FormHandler::Moose;

1;
