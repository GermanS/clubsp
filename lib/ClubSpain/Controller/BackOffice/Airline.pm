package ClubSpain::Controller::BackOffice::Airline;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

has 'template'
    => ( is => 'ro', default => 'backoffice/airline/airline.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/airline/airline_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'Airline' );

use ClubSpain::Form::BackOffice::Airline;
sub form :Private {
    my ($self, $listener) = @_;

    my $form = ClubSpain::Form::BackOffice::Airline->new();
    $form->add_listener($listener);

    return $form;
}

sub default :Path {
    my ($self, $c) = @_;

    $c->detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('airline') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $airline = $c->model($self->model)->new();
    my $form = $self->form($airline);

    $form->process($c->request->parameters);
    if ($form->validated) {
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

    my $airline = $c->model($self->model)->new();
    my $form = $self->form($airline);
    $form->process(
        init_object => {
            airline => $self->get_object($c)->name,
            iata    => $self->get_object($c)->iata,
            icao    => $self->get_object($c)->icao
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
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
