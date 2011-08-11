package ClubSpain::Controller::BackOffice::TimeTable;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Controller::BackOffice::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/timetable/timetable.tt2',
    );
};

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

#match /backoffice/timetable/*
sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $timetable;
    eval {
        $timetable = $c->model('TimeTable')->fetch_by_id($id);
        $c->stash( timetable => $timetable );
        $self->setup_stash_from_data($c);
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
};

sub create :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $form = $self->load_add_form($c);
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form     => $self->load_add_form($c),
        template => 'backoffice/timetable/timetable_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $timetable = $c->model('TimeTable')->new(
            flight_id             => $c->request->param('Flight'),
            airplane_id           => $c->request->param('airplane_id'),
            departure_terminal_id => undef,
            arrival_terminal_id   => undef,
            departure_date        => $c->request->param('DateOfDeparture'),
            departure_time        => $c->request->param('TimeOfDeparture'),
            arrival_date          => $c->request->param('DateOfArrival'),
            arrival_time          => $c->request->param('TimeOfArrival'),
            is_published          => ENABLE,
        );
        $timetable->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        form => $self->load_upd_form($c),
        template => 'backoffice/timetable/timetable_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $timetable = $c->model('TimeTable')->new(
            id                    => $c->stash->{'timetable'}->id,
            flight_id             => $c->stash->{'timetable'}->flight_id,
            airplane_id           => $c->request->param('airplane_id'),
            departure_terminal_id => undef,
            arrival_terminal_id   => undef,
            departure_date        => $c->request->param('DateOfDeparture'),
            departure_time        => $c->request->param('TimeOfDeparture'),
            arrival_date          => $c->request->param('DateOfArrival'),
            arrival_time          => $c->request->param('TimeOfArrival'),
            is_published          => $c->stash->{'timetable'}->is_published,
        );
        $timetable->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

sub load_add_form :Private {
    my ($self, $c) = @_;

    $c->stash->{'current_model_instance'} =
        $c->model('Airplane')->schema()->resultset('Airplane');

    my $form = $self->form();
    $form->load_config_filestem('backoffice/timetable_form');
    $form->get_element({ name => 'CityOfDeparture' })
         ->value( $c->stash->{'CityOfDeparture'} );
    $form->get_element({ name => 'CityOfArrival' })
         ->value( $c->stash->{'CityOfArrival'} );
    $form->process();

    return $form;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;
    my $timetable = $c->stash->{'timetable'};

    my $form = $self->load_add_form($c);
    $form->get_element({ name => 'airplane_id' })
         ->value($timetable->airplane_id);
    $form->get_element({ name => 'DateOfDeparture' })
         ->value($timetable->departure_date);
    $form->get_element({ name => 'TimeOfDeparture' })
         ->value($timetable->departure_time);
    $form->get_element({ name => 'DateOfArrival' })
         ->value($timetable->departure_date);
    $form->get_element({ name => 'TimeOfArrival' })
         ->value($timetable->departure_time);
    $form->process();

    return $form;
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    my $timetable = $c->stash->{'timetable'};
    $timetable->update({ is_published => ENABLE });

    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    my $timetable = $c->stash->{'timetable'};
    $timetable->update({ is_published => DISABLE });

    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    my $timetable = $c->stash->{'timetable'};
    $self->setup_request_from_stash($c);
    eval {
        $c->model('TimeTable')->delete($timetable->id);
        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;

    $c->detach('default');
};

sub setup_stash_from_request :Private {
    my ($self, $c) = @_;

    my @param = qw(CityOfDeparture
                   CityOfArrival
                   Flight);

    $c->stash($_ => $c->request->param($_))
        foreach (@param);
};

sub setup_request_from_stash :Private {
    my ($self, $c) = @_;

    my @param = qw(CityOfDeparture
                   CityOfArrival
                   Flight);

    $c->request->param($_, $c->stash->{$_})
        foreach (@param);
};

sub setup_stash_from_data :Private {
    my ($self, $c) = @_;

    my $timetable = $c->stash->{'timetable'};
    $c->stash({
        CityOfDeparture => $timetable->flight->departure_airport->city_id,
        CityOfArrival   => $timetable->flight->destination_airport->city_id,
        Flight          => $timetable->flight_id,
    });
};

1;
