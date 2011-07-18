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

=head2 default

Сделать редирект если не указан идентификатор билета

=cut

sub default :Path {
    my ($self, $c) = @_;

    $c->response->redirect('/');
}

sub base :Chained('/aviabilet') :PathPart('') :CaptureArgs(0) { }

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $itinerary;
    eval {
        $itinerary = $c->model('Itinerary')->fetch_by_id($id);

        $c->stash( itinerary => $itinerary )
            if ($itinerary->parent_id == 0 and $itinerary->is_published == 1);
    };

    if ($@) {
        $c->response->redirect('/charter/searchRT');
    }
}

sub view :Chained('id') :PathPart('') :Args(0) {
    my ($self, $c) = @_;

    unless ($c->stash->{'itinerary'}) {
         $c->response->redirect( '/charter/searchRT' );
    }
}

sub end :ActionClass('RenderView') {}

1;
