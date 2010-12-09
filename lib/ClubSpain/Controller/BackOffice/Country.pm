package ClubSpain::Controller::BackOffice::Country;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);

use ClubSpain::Design::Country;

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(template => 'backoffice/country.tt2')
}

sub end :ActionClass('RenderView') {}

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(iterator => ClubSpain::Design::Country->list());
}

1;
