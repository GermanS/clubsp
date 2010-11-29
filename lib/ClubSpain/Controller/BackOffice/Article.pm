package ClubSpain::Controller::BackOffice::Article;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);

use ClubSpain::Design::Article;

use constant {
    DISABLE => 0,
    ENABLE  => 1,
    MESSAGE_OK => 'Операция успешно выполнена',
};

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(template => 'backoffice/article.tt2')
}

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(iterator => ClubSpain::Design::Article->list());
}

#match /backoffice/article
sub base :Chained('/backoffice/base') :PathPart('article') :CaptureArgs(0) {};

#match /backoffice/article/*
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

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->load_add_form();
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form    => $self->load_add_form(),
        template => 'backoffice/article_form.tt2'
    );
}

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $article = ClubSpain::Design::Article->new(
            parent_id    => $c->request->param('parent_id'),
            header       => $c->request->param('header'),
            body         => $c->request->param('body'),
            is_published => ENABLE,
            weight       => undef,
        );
        $article->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

#chained /backoffice/article/*/edit
sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        form => $self->load_upd_form($c),
        template => 'backoffice/article_form.tt2'
    );
}

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $article = ClubSpain::Design::Article->new(
            id           => $c->stash->{'article'}->id,
            parent_id    => $c->request->param('parent_id'),
            weight       => $c->stash->{'article'}->weight,
            header       => $c->request->param('header'),
            body         => $c->request->param('body'),
            is_published => $c->stash->{'article'}->is_published,
        );
        $article->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};


# match /backoffice/article/*/delete
sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    eval {
        ClubSpain::Design::Article->delete($article->id);
        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;

    $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
};


# match /backoffice/article/*/delete
sub leaf :Chained('id') :PathPart('leaf') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(
        iterator => ClubSpain::Design::Article->list($c->stash->{'article'}->id)
    );
}

sub load_add_form :Private  {
    my $self = shift;

    my @options = ClubSpain::Design::Article->select_options();
    my $form = $self->form();
    $form->load_config_filestem('backoffice/article_form');
    $form->get_element({ name => 'parent_id' })->options(\@options);
    $form->process();

    return $form;
}

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form();
    my $article = $c->stash->{'article'};
    $form->get_element({ name => 'parent_id' })->value($article->parent_id);
    $form->get_element({ name => 'header' })->value($article->header);
    $form->get_element({ name => 'body' })->value($article->body);

    $form->process;

    return $form;
}

sub process_error {
    my ($self, $c, $e) = @_;

    if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $c->stash( message => $e->message );
    } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $c->stash( message => $e->message );
    } else {
        $c->stash( message => $@ );
    }
}

sub successful_message {
    my ($self, $c) = @_;

    $c->stash( message => MESSAGE_OK );
}

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    $article->update({ is_published => ENABLE });

    $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
}

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    $article->update({ is_published => DISABLE });

    $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
}

sub up :Chained('id') :Pathpart('up') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    ClubSpain::Design::Article->move_up($article);

    $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
}

sub down :Chained('id') :PathPart('down') :Args(0) {
    my ($self, $c) = @_;

    my $article = $c->stash->{'article'};
    ClubSpain::Design::Article->move_down($article);

    $c->res->redirect($c->uri_for($article->parent_id, 'leaf'));
}

sub end :ActionClass('RenderView') {}

1;
