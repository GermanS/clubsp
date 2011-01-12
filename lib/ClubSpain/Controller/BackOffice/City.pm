package ClubSpain::Controller::BackOffice::City;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);
use ClubSpain::Design::Country;
use ClubSpain::Design::City;



sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template     => 'backoffice/city.tt2',
        country_list => ClubSpain::Design::Country->list()
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(iterator => ClubSpain::Design::City->list({}));
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('city') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $city;
    eval {
        $city = ClubSpain::Design::City->fetch_by_id($id);
        $c->stash( city => $city );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'city'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('browse', $c->stash->{'city'}->country_id));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'city'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('browse', $c->stash->{'city'}->country_id));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        ClubSpain::Design::City->delete($c->stash->{'city'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('browse', $c->stash->{'city'}->country_id));
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
    $form->load_config_filestem('backoffice/city_form');
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
        template => 'backoffice/city_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $country = ClubSpain::Design::City->new(
            country_id  => $c->request->param('country_id'),
            name        => $c->request->param('name'),
            is_published => ENABLE,
        );
        $country->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form();
    my $city = $c->stash->{'city'};

    $form->get_element({ name => 'country_id' })->value($city->country_id);
    $form->get_element({ name => 'name' })->value($city->name);

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
        template => 'backoffice/city_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $city = ClubSpain::Design::City->new(
            id          => $c->stash->{'city'}->id,
            country_id  => $c->request->param('country_id'),
            name        => $c->request->param('name'),
            is_published=> $c->stash->{'city'}->is_published,
        );
        $city->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

sub browse :Local :Args(1) {
    my ($self, $c, $country) = @_;

    $c->stash(
        iterator => ClubSpain::Design::City->list({country_id => $country})
    );
}

1;