package ClubSpain::Controller::BackOffice::Employee;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Controller::BackOffice::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/employee/employee.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Employee')->search({})
    );
};

sub base :Chained('/backoffice/base') :PathPart('employee') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $employee;
    eval {
        $employee = $c->model('Employee')->fetch_by_id($id);
        $c->stash( employee => $employee );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'employee'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'employee'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Employee')->delete($c->stash->{'employee'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('default'));
};

sub load_add_form :Private  {
    my ($self, $c) = @_;

    my $form = $self->form();
    $form->load_config_filestem('backoffice/employee_form');
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
        form => $self->load_add_form($c),
        template => 'backoffice/employee/employee_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $employee = $c->model('Employee')->new(
            name         => $c->request->param('name'),
            surname      => $c->request->param('surname'),
            email        => $c->request->param('email'),
            passwd       => $c->request->param('passwd'),
            is_published => ENABLE,
        );
        $employee->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $employee = $c->stash->{'employee'};

    $form->get_element({ name => 'name' })
            ->value($employee->name);
    $form->get_element({ name => 'surname' })
            ->value($employee->surname);
    $form->get_element({ name => 'email' })
            ->value($employee->email);
    $form->get_element({ name => 'passwd' })
            ->value($employee->passwd);
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
        template => 'backoffice/employee/employee_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $employee = $c->model('Employee')->new(
            id           => $c->stash->{'employee'}->id,
            name         => $c->request->param('name'),
            surname      => $c->request->param('surname'),
            email        => $c->request->param('email'),
            passwd       => $c->request->param('passwd'),
            is_published => $c->stash->{'employee'}->is_published,
        );
        $employee->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

1;
