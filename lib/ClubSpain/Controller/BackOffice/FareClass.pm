package ClubSpain::Controller::BackOffice::FareClass;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::FareClass;

has 'template' => (
    is => 'ro',
    default => 'backoffice/fareclass/fareclass.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/fareclass/fareclass_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'FareClass',
);

sub form :Private { ClubSpain::Form::BackOffice::FareClass->new(); }


sub default :Path {
    my ($self, $c) = @_;
    $c->stash( iterator => $c->model($self->model)->search({}) );
};

sub base :Chained('/backoffice/base') :PathPart('fareclass') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->form;
    $form->fareclass($c->model($self->model)->new());
    $form->process($c->request->parameters);

    if ($form->validated) {
        my $fareclass = $form->fareclass;
        $fareclass->set_enable();

        eval { $fareclass->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->form;
    $form->fareclass($c->model($self->model)->new());
    $form->process(
        init_object => {
            name    => $self->get_object($c)->name,
            code    => $self->get_object($c)->code
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            my $fareclass = $form->fareclass;
            $fareclass->id( $self->get_object($c)->id );
            $fareclass->is_published( $self->get_object($c)->is_published );
            $fareclass->update();
        };

        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

__PACKAGE__->meta()->make_immutable();

1;
