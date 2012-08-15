package ClubSpain::Form::BackOffice::Company;
use strict;
use warnings;
use utf8;
use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler';
    with 'HTML::FormHandler::Widget::Theme::Bootstrap';


has '+name' => ( default => 'company' );

has_block 'ROW'  => ( render_list => ['left', 'right'], class => ['row'], tag => 'div' );
has_block 'left' => ( render_list => [qw(name nick country_id city_id)], class => ['span4'], tag => 'div' );
has_block 'right'=> ( render_list => [qw(INN KPP OGRN OKVED)], class => ['span7'], tag => 'div' );

has_field 'name'  =>
    ( type => 'Text', element_class => ['span4'], label => 'Юридическое название', required => 1 );
has_field 'nick'  =>
    ( type => 'Text', element_class => ['span4'], label => 'Название организации', required => 1 );
has_field 'country_id' =>
    ( type => 'Text', element_class => ['span4'], label => 'Страна', required => 1  );
has_field 'city_id' =>
    ( type => 'Text', element_class => ['span4'], label => 'Город', required => 1  );


has_field 'INN'   => ( type => 'Text', label => 'ИНН',  required => 1 );
has_field 'KPP'   => ( type => 'Text', label => 'КПП',   required => 1 );
has_field 'OGRN'  => ( type => 'Text', label => 'ОГРН',  required => 1 );
has_field 'OKVED' => ( type => 'Text', label => 'ОКВЭД', required => 1 );

has_field 'form_actions' => ( type => 'Compound' );
has_field 'form_actions.save' => ( widget => 'ButtonTag', type => 'Submit', value => 'Сохранить');
has_field 'form_actions.cancel' => ( widget => 'ButtonTag', type => 'Reset', value => 'Отменить');

sub build_form_element_class { ['well'] }
sub build_render_list { ['ROW', 'form_actions'] }
sub build_update_subfields {{
    form_actions => { do_wrapper => 1, do_label => 0 },
    'form_actions.save' => { widget_wrapper => 'None', element_class => ['btn', 'btn-primary'] },
    'form_actions.cancel' => { widget_wrapper => 'None', element_class => ['btn'] },
}}

1;
