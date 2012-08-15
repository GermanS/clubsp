package ClubSpain::Form::BackOffice::Signin;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
    extends 'ClubSpain::Form::BackOffice::Base';

has '+name' => ( default => 'signin' );

has_field 'email' => (
    element_class => ['span6'],
    label         => 'Адрес электронной почты',
    required      => 1,
    type          => 'Email'
);

has_field 'password' => (
    element_class => ['span6'],
    label         => 'Пароль',
    required      => 1,
    type          => 'Password',
);

has_field 'form_actions' => ( type => 'Compound' );
has_field 'form_actions.save' => ( widget => 'ButtonTag', type => 'Submit', value => 'Войти');

sub build_form_element_class { ['well'] }
sub build_update_subfields {{
    form_actions => { do_wrapper => 1, do_label => 0 },
    'form_actions.save' => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] }
}}

no HTML::FormHandler::Moose;

1;
