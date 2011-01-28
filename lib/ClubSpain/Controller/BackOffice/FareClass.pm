package ClubSpain::Controller::BackOffice::FareClass;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/fareclass.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('FareClass')->list({})
    );
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('fareclass') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $fareclass;
    eval {
        $fareclass = $c->model('FareClass')->fetch_by_id($id);
        $c->stash( fareclass => $fareclass );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'fareclass'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'fareclass'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('FareClass')->delete($c->stash->{'fareclass'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('default'));
};

sub process_error {
    my ($self, $c, $e) = @_;

    if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $c->stash( message => $e->message );
    } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $c->stash( message => $e->message );
    } else {
        $c->stash( message => $@ );
    }
};

sub successful_message {
    my ($self, $c) = @_;

    $c->stash( message => MESSAGE_OK );
};

sub load_add_form :Private  {
    my ($self, $c) = @_;

    my $form = $self->form();
    $form->load_config_filestem('backoffice/fareclass_form');
    $form->process();

    return $form;
};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form    => $self->load_add_form($c),
        template => 'backoffice/fareclass_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $fareclass = $c->model('FareClass')->new(
            code     => $c->request->param('code'),
            name     => $c->request->param('name'),
            is_published => ENABLE,
        );
        $fareclass->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $fareclass = $c->stash->{'fareclass'};

    $form->get_element({ name => 'code' })->value($fareclass->code);
    $form->get_element({ name => 'name' })->value($fareclass->name);

    $form->process;

    return $form;
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        form => $self->load_upd_form($c),
        template => 'backoffice/fareclass_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $fareclass = $c->model('FareClass')->new(
            id          => $c->stash->{'fareclass'}->id,
            code        => $c->request->param('code'),
            name        => $c->request->param('name'),
            is_published=> $c->stash->{'fareclass'}->is_published,
        );
        $fareclass->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

1;
