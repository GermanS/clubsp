package ClubSpain::Controller::Aviabilet;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template  => 'common/charter/ticket/ticket.tt2'
    );
}

sub default :Path { }

sub base :Chained('/aviabilet') :PathPart('') :CaptureArgs(0) { }

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $itinerary;
    eval {
        $itinerary = $c->model('Itinerary')->fetch_by_id($id);
        $c->stash( itinerary => $itinerary );
    };

    if ($@) {
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
}

sub view :Chained('id') :PathPart('') :Args(0) {
    my ($self, $c) = @_;
}

sub end :ActionClass('RenderView') {}

1;
