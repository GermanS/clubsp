package ClubSpain::Controller::BackOffice::FareClass;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

has 'template'
    => ( is => 'ro',  default => 'backoffice/fareclass/fareclass.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/fareclass/fareclass_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'FareClass' );

use ClubSpain::Form::BackOffice::FareClass;
sub form :Private {
    my ($self, $listener) = @_;

    my $form = ClubSpain::Form::BackOffice::FareClass->new();
    $form->add_listener($listener);

    return $form;
}


sub default :Path {
    my ($self, $c) = @_;
    $c->stash( iterator => $c->model($self->model)->search({}) );
};

sub base :Chained('/backoffice/base') :PathPart('fareclass') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $fareclass = $c->model($self->model)->new();
    my $form = $self->form($fareclass);

    $form->process($c->request->parameters);
    if ($form->validated) {
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

    my $fareclass = $c->model($self->model)->new();
    my $form = $self->form($fareclass);

    $form->process(
        init_object => {
            name    => $self->get_object($c)->name,
            code    => $self->get_object($c)->code
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $fareclass->set_id( $self->get_object($c)->id );
        $fareclass->set_is_published( $self->get_object($c)->is_published );

        eval { $fareclass->update(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

__PACKAGE__->meta()->make_immutable();

1;
