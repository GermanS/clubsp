package ClubSpain::Controller::Manager::Article;

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

sub view :Chained('base') :Pathpart('') :CaptureArgs(1) {
    my ($self, $c, $profile_id) = @_;

#    my $profile = $c->stash->{'profile_rs'}
#                    ->find({ id => $profile_id }, { key => 'primary' });
#
#    die "No such profile" unless $profile;
#
#    $c->stash(profile => $profile);
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

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
            $c->stash( message => $e->message );
        } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            $c->stash( message => $e->message );
        } else {
            $c->stash( message => $@ );
        }
    }
};

sub update :Chained('view') :PathPart('update') :Args(0) {
#    my ($self, $c) = @_;

#    my $object = $c->stash->{'profile'}->update({
#        email    => $c->request->param('email'),
#        password => $c->request->param('password'),
#    });
};

sub delete :Chained('view') :PathPart('delete') :Args(0) {
#    my ($self, $c) = @_;

#    my $object = $c->stash->{'profile'}->delete();
};

sub load_add_form {
    my ($self, $c) = @_;

    my $form = $self->form();
    $form->load_config_filestem('manager/article_form');
    $form->process();

    return $form;
}

sub end : ActionClass('RenderView') {
}


1;
