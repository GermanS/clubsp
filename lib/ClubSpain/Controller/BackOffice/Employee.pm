package ClubSpain::Controller::BackOffice::Employee;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Employee;
sub form :Private {
    my ($self, $listener) = @_;
    return ClubSpain::Form::BackOffice::Employee->new({
        listeners => [ $listener ]
    });
};

has 'template'
    => ( is => 'ro', default => 'backoffice/employee/employee.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/employee/employee_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'Employee' );

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
        init_object  => {
            name       => $self->get_object($c)->name,
            surname    => $self->get_object($c)->surname,
            email      => $self->get_object($c)->email,
            password   => $self->get_object($c)->password
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $employee->set_id(
            $self->get_object($c)->id
        );
        $employee->set_is_published(
            $self->get_object($c)->is_published
        );

        eval { $employee->update(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

__PACKAGE__->meta->make_immutable();

1;
