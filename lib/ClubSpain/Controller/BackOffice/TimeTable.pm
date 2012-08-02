package ClubSpain::Controller::BackOffice::TimeTable;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Constants qw(:all);
use ClubSpain::Form::BackOffice::TimeTable;
sub form :Private {
    my ($self, $model) = @_;
    return ClubSpain::Form::BackOffice::TimeTable->new( model_object => $model );
};

has 'template' => (
    is => 'ro',
    default => 'backoffice/timetable/timetable.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/timetable/timetable_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Timetable',
);


sub default :Path {
    my ($self, $c) = @_;

    if ($c->request->param('CityOfDeparture') &&
        $c->request->param('CityOfArrival') &&
        $c->request->param('Flight')) {

        my $iterator = $c->model('TimeTable')->search({
            flight_id      => $c->request->param('Flight'),
            departure_date => \'>=NOW()',
        }, {
            order_by => [qw(departure_date)]
        });

        $c->stash( iterator => $iterator );
        $self->setup_stash_from_request($c);
    }
};

sub base :Chained('/backoffice/base') :PathPart('timetable') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;
    $self->setup_stash_from_request($c);

    my $timetable = $c->model($self->model)->new();
    my $form = $self->form($timetable);

    my $is_posted = exists ($c->request->parameters->{'airplane_id'});
    $form->process(
        posted => $is_posted,
        init_object => {
            CityOfDeparture    => $c->request->param('CityOfDeparture'),
            CityOfArrival      => $c->request->param('CityOfArrival'),
            Flight             => $c->request->param('Flight'),
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $timetable->set_enable();
        $timetable->is_free(FREE);

        eval { $timetable->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    $self->setup_stash_from_data($c);

    my $timetable = $c->model($self->model)->new();
    my $form = $self->form($timetable);
    $form->process(
        init_object => {
            CityOfDeparture     => $self->get_object($c)->flight->departure_airport->city_id,
            CityOfArrival       => $self->get_object($c)->flight->destination_airport->city_id,
            Flight              => $self->get_object($c)->flight_id,
            airplane_id         => $self->get_object($c)->airplane_id,
            DateOfDeparture     => $self->get_object($c)->departure_date,
            TimeOfDeparture     => $self->get_object($c)->departure_time,
            DateOfArrival       => $self->get_object($c)->arrival_date,
            TimeOfArrival       => $self->get_object($c)->arrival_time,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            $timetable->id( $self->get_object($c)->id );
            $timetable->is_published( $self->get_object($c)->is_published );
            $timetable->is_free( $self->get_object($c)->is_free );

            $timetable->update();
        };

        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $self->get_object($c)->update({ is_published => ENABLE });

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $self->get_object($c)->update({ is_published => DISABLE });

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub free :Chained('id') :PathPart('free') :Args(0) {
    my ($self, $c) = @_;

    $c->model($self->model)->set_free( timetable => $self->get_object($c) );

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub request :Chained('id') :PathPart('request') :Args(0) {
    my ($self, $c) = @_;

    $c->model($self->model)->set_request( timetable => $self->get_object($c) );

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub sold :Chained('id') :PathPart('sold') :Args(0) {
    my ($self, $c) = @_;

    $c->model($self->model)->set_sold( timetable => $self->get_object($c) );

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub enable_tariffs:Chained('id') :PathPart('enable_tariffs') :Args(0) {
    my ($self, $c) = @_;

    $c->model($self->model)->enable_tariffs( timetable => $self->get_object($c)  );

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
}

sub disable_tariffs:Chained('id') :PathPart('disable_tariffs') :Args(0) {
    my ($self, $c) = @_;

    $c->model($self->model)->disable_tariffs( timetable => $self->get_object($c) );

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
}

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);

    eval { $c->model($self->model)->delete( $self->get_object($c)->id ); };
    $self->show_message(context => $c, error => $@);

    $c->detach('default');
};

sub setup_stash_from_request :Private {
    my ($self, $c) = @_;

    $c->stash($_ => $c->request->param($_))
        foreach qw(CityOfDeparture CityOfArrival Flight);
};

sub setup_request_from_stash :Private {
    my ($self, $c) = @_;

    $c->request->param($_, $c->stash->{$_})
        foreach qw(CityOfDeparture CityOfArrival Flight);
};

sub setup_stash_from_data :Private {
    my ($self, $c) = @_;

    $c->stash({
        CityOfDeparture => $self->get_object($c)->flight->departure_airport->city_id,
        CityOfArrival   => $self->get_object($c)->flight->destination_airport->city_id,
        Flight          => $self->get_object($c)->flight_id,
    });
};

__PACKAGE__->meta->make_immutable();

1;
