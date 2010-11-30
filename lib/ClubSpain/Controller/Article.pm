package ClubSpain::Controller::Article;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller);
use ClubSpain::Design::Article;


sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        top_level => ClubSpain::Design::Article->list(),
        template  => 'common/article.tt2'
    );
}

sub default :Path {
    my ($self, $c) = @_;

#    $c->stash( top_level => ClubSpain::Design::Article->list() );
}

sub base :Chained('/article') :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;

}

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $article;
    eval {
        $article = ClubSpain::Design::Article->fetch_by_id($id);
        $c->stash( article => $article );
    };

    if ($@) {
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
}

sub view : Chained('id') :PathPart('') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    $c->stash(lower_level => ClubSpain::Design::Article->list($article->id));
}




=head
# match /article (end of chain)
sub root :Chained('base') :PathPart('') :Args(0) {}
=cut

=head

#match /article/*
sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $article;
    eval {
        $article = ClubSpain::Design::Article->fetch_by_id($id);
        $c->stash( article => $article );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
};

=cut



sub end :ActionClass('RenderView') {}

1;
