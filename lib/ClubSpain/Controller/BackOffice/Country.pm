package ClubSpain::Controller::BackOffice::Country;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Country;

has 'template' => (
    is => 'ro',
    default => 'backoffice/country/country.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/country/country_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Country',
);

sub form :Private { ClubSpain::Form::BackOffice::Country->new(); }

sub default :Path {
    my ($self, $c) = @_;

    $c->detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('country') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->form;
    $form->country($c->model($self->model)->new());
    $form->process($c->request->parameters);

    if ($form->validated) {
        my $country = $form->country;
        $country->set_enable();

        eval { $country->create(); };
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
    $form->country($c->model($self->model)->new());
    $form->process(
        init_object => {
            name     => $self->get_object($c)->name,
            alpha2   => $self->get_object($c)->alpha2,
            alpha3   => $self->get_object($c)->alpha3,
            numerics => $self->get_object($c)->numerics
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            my $country = $form->country();
            $country->id( $self->get_object($c)->id );
            $country->is_published( $self->get_object($c)->is_published );
            $country->update();
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
