package ClubSpain::Controller::Flight;
use strict;
use warnings;
use utf8;
use parent qw(Catalyst::Controller);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template  => 'common/flight/flight.tt2'
    );
}

sub base :Chained('/flight') :PathPart('') :CaptureArgs(0) {
}

sub end :ActionClass('RenderView') {
}

sub default :Path {
}


1;
