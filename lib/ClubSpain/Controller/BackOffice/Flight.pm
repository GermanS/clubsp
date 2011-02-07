package ClubSpain::Controller::BackOffice::Flight;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/flight/flight.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('flight') :CaptureArgs(0) {};

1;
