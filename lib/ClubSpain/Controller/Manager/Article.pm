package ClubSpain::Controller::BackOffice::Article;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);

use ClubSpain::Design::Article;

sub base :Chained('/') :PathPart('article') :CaptureArgs(0) {
    my ($self, $c) = @_;

#    $c->stash(profile_rs => $c->model('DBIC::User'));
};


sub index :Local {
    my ($self, $c) = @_;

    $c->stash(template => 'admin/article.tt2');
}

sub view :Chained :Path('/manager/article/view') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $article;
    eval {
        $article = ClubSpain::Design::Article->fetch_by_id($id);
        $c->stash( article => $article );
    };

    $self->process_error($c, $@) if $@;

    $c->stash(template => 'admin/article_view.tt2');
};

sub add_form :Local {
    my ($self, $c) = @_;

    my $form = $self->load_add_form();
    $c->stash(form => $form);
    $c->stash(template => 'admin/article_form.tt2');

    if ($form->submitted_and_valid()) {
        $self->create($c);
    }
}

sub create :Private {
    my ($self, $c) = @_;

    eval {
        my $article = ClubSpain::Design::Article->new(
            parent_id    => $c->request->param('parent_id'),
            weight       => $c->request->param('weight'),
            is_published => $c->request->param('is_published') || 0,
            header       => $c->request->param('header'),
            body         => $c->request->param('body')
        );
        $article->create();

        $c->stash(message => 'Статья успешно добавлена');
    };

    $self->process_error($c, $@)
        if $@;
};

sub upd_form :Local :Chained('view') :Args(1) {
    my ($self, $c, $id) = @_;

    my $form = $self->load_upd_form($c, $id);
    $c->stash(form => $form);
    $c->stash(template => 'admin/article_form.tt2');

    if ($form->submitted_and_valid()) {
        $self->update($id);
    }
}

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $article = ClubSpain::Design::Article->new(
            id           => $c->request->param('id'),
            weight       => $c->request->param('weight'),
            is_published => $c->request->param('is_published') || 0,
            header       => $c->request->param('header'),
            body         => $c->request->param('body')
        );
        $article->update();

        $c->stash( message => 'Статья успешно обновлена' );
    };

    $self->process_error($c)
         if $@;
};

sub delete :Chained('view') :PathPart('delete') :Args(0) {
#    my ($self, $c) = @_;

#    my $object = $c->stash->{'profile'}->delete();
};

sub load_add_form :Private  {
    my $self = shift;

    my $form = $self->form();
    $form->load_config_filestem('manager/article_form');
    $form->process();

    return $form;
}

sub load_upd_form {
    my ($self, $c, $id) = @_;

    $c->log->debug("THE ID: $id");

    my $form = $self->load_add_form();
    my $article = ClubSpain::Design::Article->fetch_by_id($id);
    $form->get_element({ name => 'parent_id' })->value($article->parent_id);
    $form->get_element({ name => 'header' })->value($article->header);
    $form->get_element({ name => 'body' })->value($article->body);
    $form->get_element({ name => 'weight' })->value($article->weight);
    $form->get_element({ name => 'is_published' })->checked($article->is_published)
        if $article->is_published;

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

sub seccessful_message {
    my ($self, $c) = @_;

    $c->stash( message => 'Операция успешно выполнена' );
}

sub end : ActionClass('RenderView') {
}

1;
