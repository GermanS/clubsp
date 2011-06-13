package ClubSpain::Controller::Article;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        top_level => $c->model('Article')->list(),
        template  => 'common/article/article.tt2'
    );
}

sub default :Path { }

sub base :Chained('/article') :PathPart('') :CaptureArgs(0) { }

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $article;
    eval {
        $article = $c->model('Article')->fetch_by_id($id);
        $c->stash( article => $article );
    };

    if ($@) {
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
}

sub view :Chained('id') :PathPart('') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    $c->stash(lower_level => $c->model('Article')->list($article->id));

    my $top_level_article = $c->model('Article')->find_top_parent($article);
    $c->stash(top_level_article => $top_level_article);

    my $sidebar_tree = $c->model('Article')->tree($top_level_article->id);
    $c->stash(sidebar_tree => $sidebar_tree);
}

sub end :ActionClass('RenderView') {}

1;
