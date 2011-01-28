package ClubSpain::Controller::BackOffice::Manufacturer;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);


sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/manufacturer.tt2'
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Manufacturer')->search({})
    );
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('manufacturer') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $manufacturer;
    eval {
        $manufacturer = $c->model('Manufacturer')->fetch_by_id($id);
        $c->stash( manufacturer => $manufacturer );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Manufacturer')->delete($c->stash->{'manufacturer'}->id);
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
    my $self = shift;

    my $form = $self->form();
    $form->load_config_filestem('backoffice/manufacturer_form');
    $form->process();

    return $form;
};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->load_add_form();
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form    => $self->load_add_form(),
        template => 'backoffice/manufacturer_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $manufacturer = $c->model('Manufacturer')->new(
            name    => $c->request->param('name'),
            code    => $c->request->param('code'),
        );
        $manufacturer->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form();
    my $manufacturer = $c->stash->{'manufacturer'};
    $form->get_element({ name => 'name' })->value($manufacturer->name);
    $form->get_element({ name => 'code' })->value($manufacturer->code);

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
        template => 'backoffice/manufacturer_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $manufacturer = $c->model('Manufacturer')->new(
            id      => $c->stash->{'manufacturer'}->id,
            name    => $c->request->param('name'),
            code    => $c->request->param('code'),
        );
        $manufacturer->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

1;
