package ClubSpain::Controller::BackOffice::Article;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Article;
sub form :Private {
    my ($self, $listener) = @_;
    return ClubSpain::Form::BackOffice::Article->new({
        listeners => [ $listener ]
    });
}

has 'template'
    => ( is => 'ro', default => 'backoffice/article/article.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/article/article_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'Article' );


sub default :Path {
    my ($self, $c) = @_;
    $c->stash(iterator => $c->model('Article')->list());
}

#match /backoffice/article
sub base :Chained('/backoffice/base') :PathPart('article') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $article = $c->model($self->model)->new();
    my $form = $self->form($article);
    $form->process($c->request->parameters);

    if ($form->validated) {
        $article->set_enable();

        eval { $article->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );

};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->model($self->model)->new();
    my $form = $self->form($article);
    $form->process(
        init_object => {
            parent_id   => $self->get_object($c)->parent_id,
            header      => $self->get_object($c)->header,
            subheader   => $self->get_object($c)->subheader,
            body        => $self->get_object($c)->body,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $article->id(
            $self->get_object($c)->id
        );
        $article->weight(
            $self->get_object($c)->weight
        );
        $article->is_published(
            $self->get_object($c)->is_published
        );

        eval { $article->update(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

# match /backoffice/article/*/leaf
sub leaf :Chained('id') :PathPart('leaf') :Args(0) {
    my ($self, $c) = @_;

    my $iterator = $self->get_object($c)
        ? $c->model('Article')->list($self->get_object($c)->id)
        : undef;

    $c->stash( iterator => $iterator );
}

sub up :Chained('id') :Pathpart('up') :Args(0) {
    my ($self, $c) = @_;

    my $article = $self->get_object($c);
    $c->model('Article')->move_up( $article );

    if ($article->parent_id) {
        $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
    } else {
        $c->res->redirect($c->uri_for('default'));
    }
}

sub down :Chained('id') :PathPart('down') :Args(0) {
    my ($self, $c) = @_;

    my $article = $self->get_object($c);
    $c->model('Article')->move_down( $article );

    if ($article->parent_id) {
        $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
    } else {
        $c->res->redirect($c->uri_for('default'));
    }
}

1;
