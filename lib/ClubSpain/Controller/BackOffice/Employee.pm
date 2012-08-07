package ClubSpain::Controller::BackOffice::Employee;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Employee;
sub form :Private {
    my ($self, $model) = @_;
    return ClubSpain::Form::BackOffice::Employee->new( model_object => $model );
};

has 'template' => (
    is => 'ro',
    default => 'backoffice/employee/employee.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/employee/employee_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Employee',
);

sub default :Path {
    my ($self, $c) = @_;
    $c->stash( iterator => $c->model($self->model)->search({}) );
};

sub base :Chained('/backoffice/base') :PathPart('employee') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $employee = $c->model($self->model)->new();
    my $form = $self->form($employee);
    $form->process($c->request->parameters);

    if ($form->validated) {
        $employee->set_enable();

        eval { $employee->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $employee = $c->model($self->model)->new();
    my $form = $self->form($employee);
    $form->process(
        init_object => {
            name    => $self->get_object($c)->name,
            surname => $self->get_object($c)->surname,
            email   => $self->get_object($c)->email,
            passwd  => $self->get_object($c)->passwd
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            $employee->id( $self->get_object($c)->id );
            $employee->is_published( $self->get_object($c)->is_published );
            $employee->update();
        };

        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

=head

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

=cut

__PACKAGE__->meta->make_immutable();

1;
