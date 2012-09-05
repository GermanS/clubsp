package ClubSpain::Controller::BackOffice::Airport;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Airport;
sub form :Private {
    my ($self, $listener) = @_;
    return ClubSpain::Form::BackOffice::Airport->new({
        listeners => [ $listener ]
    });
}

has 'template'
    => ( is => 'ro', default => 'backoffice/airport/airport.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/airport/airport_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'Airport' );

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template     => $self->template,
        country_list => $c->model('Country')->search({})
    );
};


sub default :Path {
    my ($self, $c) = @_;

    $c->detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('airport') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $port = $c->model($self->model)->new();
    my $form = $self->form($port);
    $form->process($c->request->parameters);

    if ($form->validated) {
        $port->set_enable();

        eval { $port->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $port = $c->model($self->model)->new();
    my $form = $self->form($port);
    $form->process(
        init_object => {
            city_id => $self->get_object($c)->city_id,
            name    => $self->get_object($c)->name,
            iata    => $self->get_object($c)->iata,
            icao    => $self->get_object($c)->icao,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $port->set_id(
            $self->get_object($c)->id
        );
        $port->set_is_published(
            $self->get_object($c)->is_published
        );

        eval { $port->update(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};


sub country :Local :Args(1) {
    my ($self, $c, $country_id) = @_;

    $c->stash(
        selected_country => $c->model('Country')->fetch_by_id($country_id)
    );

    unless ($c->stash->{'iterator'}) {
        $c->stash(
            iterator => $c->model('Airport')->search(
                { 'city.country_id' => $country_id },
                { join => 'city' }
            )
        );
    }
}

sub city :Local :Args(1) {
    my ($self, $c, $city_id) = @_;

    my $city = $c->model('City')->fetch_by_id($city_id);
    $c->stash( selected_city => $city );

    $self->country($c, $city->country_id);

    $c->stash(
        iterator => $c->model('Airport')->search({
            city_id => $city_id
        })
    );
}

__PACKAGE__->meta->make_immutable();

1;
