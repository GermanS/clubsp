package ClubSpain::Controller::BackOffice::Airline;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Airline;

has 'template' => (
    is => 'ro',
    default => 'backoffice/airline/airline.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/airline/airline_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Airline',
);

sub form :Private { ClubSpain::Form::BackOffice::Airline->new(); }

sub default :Path {
    my ($self, $c) = @_;

    $c->detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('airline') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->form;
    $form->airline($c->model($self->model)->new());
    $form->process($c->request->parameters);

    if ($form->validated) {
        my $airline = $form->airline;
        $airline->set_enable();

        eval { $airline->create(); };
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
    $form->airline($c->model($self->model)->new());
    $form->process(
        init_object => {
            name    => $self->get_object($c)->name,
            iata    => $self->get_object($c)->iata,
            icao    => $self->get_object($c)->icao
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            my $airline = $form->airline;
            $airline->id( $self->get_object($c)->id );
            $airline->is_published( $self->get_object($c)->is_published );
            $airline->update();
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
