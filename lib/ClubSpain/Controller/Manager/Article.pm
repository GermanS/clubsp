package ClubSpain::Controller::Manager::Article;

use strict;
use warnings;

use parent qw(Catalyst::Controller);

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

sub add_form: Local {
    my ($self, $c) = @_;

    $c->stash(template => 'admin/article_form.tt2');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

#    my $object = $c->stash->{'profile_rs'}->create({
#        email    => $c->request->param('email'),
#        password => $c->request->param('password'),
#    });
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


sub end : ActionClass('RenderView') {
}
1;
