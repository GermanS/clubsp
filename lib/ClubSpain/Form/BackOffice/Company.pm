package ClubSpain::Form::BackOffice::Company;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Types qw(:all);
use HTML::FormHandler::Moose;
extends 'ClubSpain::Form::BackOffice::Base';
with 'ClubSpain::Model::Role::Company';

has '+name' => ( default => 'company' );

#legal block
has_block 'legal'
    => ( render_list => ['block_legal_index', 'block_legal_address'], class=> ['row'], tag => 'div' );
has_block 'block_legal_index'
    => ( render_list => [qw(legal_index)], class => ['span1'], tag => 'div' );
has_block 'block_legal_address'
    => ( render_list => [qw(legal_address)], class => ['span7'], tag => 'div' );

has_field 'legal_index' => (
    apply           => [ Trim ],
    element_class   => ['span1'],
    label           => 'Индекс',
    minlength       => 6,
    maxlength       => 6,
    required        => 1,
    type            => 'Integer',
);
has_field 'legal_address' => (
    apply           => [ Trim ],
    element_class   => ['span7'],
    label           => 'Юридический адрес',
    minlength       => 5,
    maxlength       => 255,
    required        => 1,
    type            => 'Text',
);

#actual block
has_block 'actual'
    => ( render_list => ['block_actual_index', 'block_actual_address'], class=> ['row'], tag => 'div' );
has_block 'block_actual_index'
    => ( render_list => [qw(actual_index)], class => ['span1'], tag => 'div' );
has_block 'block_actual_address'
    => ( render_list => [qw(actual_address)], class => ['span7'], tag => 'div' );
has_field 'actual_index' => (
    apply           => [ Trim ],
    element_class   => ['span1'],
    label           => 'Индекс',
    minlength       => 6,
    maxlength       => 6,
    required        => 1,
    type            => 'Integer',
);
has_field 'actual_address' => (
    apply           => [ Trim ],
    element_class   => ['span7'],
    label           => 'Фактический адрес',
    minlength       => 5,
    maxlength       => 255,
    required        => 1,
    type            => 'Text',
);

has_field 'name' => (
    apply           => [ Trim ],
    element_class   => ['span8'],
    label           => 'Юридическое название',
    minlength       => 5,
    maxlength       => 255,
    required        => 1,
    type            => 'Text',
);
has_field 'nick' => (
    apply           => [ Trim ],
    element_class   => ['span8'],
    label           => 'Название организации',
    minlength       => 5,
    maxlength       => 255,
    required        => 1,
    type            => 'Text',
);
has_field 'website' => (
    apply           => [ Trim ],
    element_class   => ['span8'],
    label           => 'Сайт организации',
    minlength       => 5,
    maxlength       => 255,
    required        => 1,
    type            => 'Text',
);

has_block 'details'
    => ( render_list => ['registration_details', 'banking_details'], class => ['row'], tag => 'div' );

#registration details
has_block 'registration_details'
    => ( render_list => [qw(INN OKPO OKVED phone email)], class => ['span4'], tag => 'div' );
has_field 'INN' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'ИНН',
    minlength       => 10,
    maxlength       => 12,
    required        => 1,
    type            => 'Integer',
);
has_field 'OKPO' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'ОКПО',
    minlength       => 8,
    maxlength       => 10,
    required        => 1,
    type            => 'Integer',
);
has_field 'OKVED' => (
    element_class   => ['span4'],
    label           => 'ОКВЭД',
    required        => 1,
    type            => 'Text',
);
has_field 'phone' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'Контактный телефон',
    minlength       => 10,
    maxlength       => 10,
    required        => 1,
    type            => 'Integer',
);
has_field 'email' => (
    element_class   => ['span4'],
    label           => 'Email',
    required        => 1,
    type            => 'Email',
);

#banking details
has_block 'banking_details'
    => ( render_list => [qw(bank_account correspondent_account bic bank is_NDS)], class => ['span4'], tag => 'div' );

has_field 'bank_account' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'Расчетный счет',
    minlength       => 20,
    maxlength       => 20,
    required        => 1,
    type            => 'Integer',
);
has_field 'correspondent_account' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'Корреспондентский счет',
    minlength       => 20,
    maxlength       => 20,
    required        => 1,
    type            => 'Integer',
);
has_field 'BIC' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'БИК',
    minlength       => 9,
    maxlength       => 9,
    required        => 1,
    type            => 'Integer',
);
has_field 'bank' => (
    apply           => [ Trim ],
    element_class   => ['span4'],
    label           => 'Название банка',
    minlength       => 4,
    maxlength       => 100,
    required        => 1,
    type            => 'Text',
);
has_field 'is_NDS' => ( type => 'Boolean', label => 'Является ли Агент плательщиком НДС?' );

has_field 'form_actions' => ( type => 'Compound' );
has_field 'form_actions.save' => ( widget => 'ButtonTag', type => 'Submit', value => 'Сохранить');
has_field 'form_actions.cancel' => ( widget => 'ButtonTag', type => 'Reset', value => 'Отменить');


sub build_form_element_class { ['well'] }
sub build_render_list { ['legal', 'actual', 'company', 'nick', 'website', 'details', 'form_actions'] }
sub build_update_subfields {{
    form_actions => { do_wrapper => 1, do_label => 0 },
    'form_actions.save' => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] },
    'form_actions.cancel' => { widget_wrapper => 'None', element_class => ['btn'] },
}}

sub get_company {
    my $self = shift;

    return ClubSpain::Model::Company->new({
        zipcode => $self->field('legal_index')->value,
        street  => $self->field('legal_address')->value,
        name    => $self->field('name')->value,
        nick    => $self->field('nick')->value,
        website => $self->field('website')->value,
        INN     => $self->field('INN')->value,
        OKPO    => $self->field('OKPO')->value,
        OKVED   => $self->field('OKVED')->value,
        is_NDS  => $self->field('is_NDS')->value,
    })
};
sub get_bank_account {
    my $self = shift;

    return ClubSpain::Model::BankAccount->new({
        bank_account          => $self->field('bank_account')->value,
        correspondent_account => $self->field('correspondent_account')->value,
        BIC                   => $self->field('BIC')->value,
        bank                  => $self->field('bank')->value,
    });
}

sub get_office {
    my $self = shift;

    return ClubSpain::Model::Office->new({
        zipcode => $self->field('actual_index')->value,
        street  => $self->field('actual_address')->value,
        phone   => $self->field('phone')->value,
    })
}

#implement ClubSpain::Model::Role::Company
sub get_zipcode { shift->field('legal_index')->value(); }
sub set_zipcode { shift->field('legal_index')->value(@_); }
sub get_street  { shift->field('legal_address')->value(); }
sub set_street  { shift->field('legal_address')->value(@_); }
sub get_name    { shift->field('name')->value(); }
sub set_name    { shift->field('name')->value(@_); }
sub get_nick    { shift->field('nick')->value(); }
sub set_nick    { shift->field('nick')->value(@_); }
sub get_website { shift->field('website')->value(); }
sub set_website { shift->field('website')->value(@_); }
sub get_INN     { shift->field('INN')->value(); }
sub set_INN     { shift->field('INN')->value(@_); }
sub get_OKPO    { shift->field('OKPO')->value(); }
sub set_OKPO    { shift->field('OKPO')->value(@_); }
sub get_OKVED   { shift->field('OKVED')->value(); }
sub set_OKVED   { shift->field('OKVED')->value(@_); }
sub get_is_NDS  { shift->field('is_NDS')->value(); }
sub set_is_NDS  { shift->field('is_NDS')->value(@_); }

sub validate_legal_index { shift->validate_zipcode(@_); }
sub validate_zipcode {
    my ($self, $field) = @_;
    $self->check_field('validate_zipcode', $field);
}
sub validate_legal_address {
    my ($self, $field) = @_;
    $self->validate_street($field);
}
sub validate_actual_index { shift->validate_zipcode(@_); }
sub validate_street  {
    my ($self, $field) = @_;
    $self->check_field('validate_street', $field);
}
sub validate_name {
    my ($self, $field) = @_;
    $self->check_field('validate_name', $field);
}
sub validate_nick    {
    my ($self, $field) = @_;
    $self->check_field('validate_nick', $field);
}
sub validate_website {
    my ($self, $field) = @_;
    $self->check_field('validate_website', $field);
}
sub validate_INN     {
    my ($self, $field) = @_;
    $self->check_field('validate_INN', $field);
}
sub validate_OKPO    {
    my ($self, $field) = @_;
    $self->check_field('validate_OKPO', $field);
}
sub validate_OKVED   {
    my ($self, $field) = @_;
    $self->check_field('validate_OKVED', $field);
}
sub validate_is_NDS  {
    my ($self, $field) = @_;
    $self->check_field('validate_is_NDS', $field);
}

no HTML::FormHandler::Moose;

1;
