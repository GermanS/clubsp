package ClubSpain::Controller::BackOffice::Airplane;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);


sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template          => 'backoffice/airplane.tt2',
        manufacturer_list => $c->model('Manufacturer')->list({})
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Airplane')->list({}),
    );
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('airplane') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $airplane;
    eval {
        $airplane = $c->model('Airplane')->fetch_by_id($id);
        $c->stash( airplane => $airplane );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'airplane'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('browse', $c->stash->{'airplane'}->manufacturer_id));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'airplane'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('browse', $c->stash->{'airplane'}->manufacturer_id));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Airplane')->delete($c->stash->{'airplane'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('browse', $c->stash->{'airplane'}->manufacturer_id));
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

    $c->stash->{'current_model_instance'} =
        $c->model('Airplane')->schema()->resultset('Manufacturer');

    my $form = $self->form();
    $form->load_config_filestem('backoffice/airplane_form');
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
        template => 'backoffice/airplane_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $country = $c->model('Airplane')->new(
            manufacturer_id => $c->request->param('manufacturer_id'),
            iata            => $c->request->param('iata'),
            icao            => $c->request->param('icao'),
            name            => $c->request->param('name'),
            is_published    => ENABLE,
        );
        $country->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $airplane = $c->stash->{'airplane'};

    $form->get_element({ name => 'manufacturer_id' })->value($airplane->manufacturer_id);
    $form->get_element({ name => 'iata' })->value($airplane->iata);
    $form->get_element({ name => 'icao' })->value($airplane->icao);
    $form->get_element({ name => 'name' })->value($airplane->name);

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
        template => 'backoffice/airplane_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $airplane = $c->model('Airplane')->new(
            id              => $c->stash->{'airplane'}->id,
            manufacturer_id => $c->request->param('manufacturer_id'),
            iata            => $c->request->param('iata'),
            icao            => $c->request->param('icao'),
            name            => $c->request->param('name'),
            is_published    => $c->stash->{'airplane'}->is_published,
        );
        $airplane->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

sub browse :Local :Args(1) {
    my ($self, $c, $manufacturer) = @_;

    $c->stash(
        iterator => $c->model('Airplane')->list({
            manufacturer_id => $manufacturer
        })
    );
}

1;
