package ClubSpain::Form::BackOffice::Customer;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Customer';

has '+name' => ( default => 'customer' );

has_field 'name' => (
    element_class => ['span11'],
    label         => 'Имя клиента',
    required      => 1,
    type          => 'Text'
);
has_field 'surname' => (
    element_class => ['span11'],
    label         => 'Фамилия клиента',
    required      => 1,
    type          => 'Text'
);
has_field 'email' => (
    element_class => ['span11'],
    label         => 'Адрес электронной почты',
    required      => 1,
    type          => 'Text'
);
has_field 'passwd' => (
    element_class => ['span2'],
    label         => 'Пароль',
    required      => 1,
    type          => 'Text'
);
has_field 'mobile' => (
    element_class => ['span2'],
    label         => 'Номер мобильного телефона',
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

sub get_name { shift->field('name')->value; }
sub set_name { shift->field('name')->value(@_); }
sub get_surname { shift->field('surname')->value; }
sub set_surname { shift->field('surname')->value(@_); }
sub get_email { shift->field('email')->value; }
sub set_email { shift->field('email')->value(@_); }
sub get_passwd { shift->field('passwd')->value; }
sub set_passwd { shift->field('passwd')->value(@_); }
sub get_mobile { shift->field('mobile')->value; }
sub set_mobile { shift->field('mobile')->value(@_); }

sub validate_name {
    my ($self, $field) = @_;
    $self->check_field('validate_name', $field);
}
sub validate_surname {
    my ($self, $field) = @_;
    $self->check_field('validate_surname', $field);
}
sub validate_email {
    my ($self, $field) = @_;
    $self->check_field('validate_email', $field);
}
sub validate_passwd {
    my ($self, $field) = @_;
    $self->check_field('validate_passwd', $field);
}
sub validate_mobile {
    my ($self, $field) = @_;
    $self->check_field('validate_mobile', $field);
}

no HTML::FormHandler::Moose;

1;
