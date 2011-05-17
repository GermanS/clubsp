package ClubSpain::Controller::BackOffice::Country;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);



sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(template => 'backoffice/country/country.tt2')
};



sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Country')->search({})
    );
};



sub end :ActionClass('RenderView') {};



sub base :Chained('/backoffice/base') :PathPart('country') :CaptureArgs(0) {};



sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $country;
    eval {
        $country = $c->model('Country')->fetch_by_id($id);
        $c->stash( country => $country );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};



sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'country'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};



sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'country'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};



sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Country')->delete($c->stash->{'country'}->id);
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
    $form->load_config_filestem('backoffice/country_form');
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
        template => 'backoffice/country/country_form.tt2'
    );
};



sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $country = $c->model('Country')->new(
            name        => $c->request->param('name'),
            alpha2      => $c->request->param('alpha2'),
            alpha3      => $c->request->param('alpha3'),
            numerics    => $c->request->param('numerics'),
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
    my $country = $c->stash->{'country'};
    $form->get_element({ name => 'name'     })->value($country->name);
    $form->get_element({ name => 'alpha2'   })->value($country->alpha2);
    $form->get_element({ name => 'alpha3'   })->value($country->alpha3);
    $form->get_element({ name => 'numerics' })->value($country->numerics);

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
        template => 'backoffice/country/country_form.tt2'
    );
};



sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $country = $c->model('Country')->new(
            id          => $c->stash->{'country'}->id,
            name        => $c->request->param('name'),
            alpha2      => $c->request->param('alpha2'),
            alpha3      => $c->request->param('alpha3'),
            numerics    => $c->request->param('numerics'),
            is_published=> $c->stash->{'country'}->is_published,
        );
        $country->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

1;
