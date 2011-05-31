package ClubSpain::Controller::BackOffice::Fare;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);


sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/itinerary/itinerary_search_RT.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $timetable1 = $c->request->param('Flight1');
    if ($timetable1) {
        my @route;
        my $timetable2 = $c->request->param('Flight2');

        for ($timetable1, $timetable2) {
            if ($_) {
                my $route = $c->model('TimeTable')->fetch_by_id($_);
                push @route, $route->id
                    if $_ == $route->id;
            }
        };

        my $iterator = $c->model('Itinerary')->searchItinerary(@route);
        $c->stash(
            iterator => $iterator,
            template => ( scalar @route == 1 )
                ? 'backoffice/itinerary/itinerary_search_OW.tt2'
                : 'backoffice/itinerary/itinerary_search_RT.tt2',
        );

    }
};

sub end :ActionClass('RenderView') {}

sub base :Chained('/backoffice/base') :PathPart('fare') :CaptureArgs(0) {}

sub searchOW :Local {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/itinerary/itinerary_search_OW.tt2'
    );

    $c->detach('default');
}

#match /backoffice/fare/*
sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $itinerary;
    eval {
        $itinerary = $c->model('Itinerary')->fetch_by_id($id);
        $c->stash( itinerary => $itinerary );
        $self->setup_stash_from_data($c);
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
};


sub createOW : Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $form = $self->load_add_form($c);
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    my $timetable1 = $c->model('TimeTable')->fetch_by_id($c->request->param('Flight1'));

    $c->stash(
        form       => $self->load_add_form($c),
        template   => 'backoffice/itinerary/itinerary_form_OW.tt2',
        timetable1 => $timetable1
    );
}

sub createRT : Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);


    my $form = $self->load_add_form($c);
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    my $timetable1 =
        $c->model('TimeTable')->fetch_by_id($c->request->param('Flight1'));

    my $timetable2 =
        $c->model('TimeTable')->fetch_by_id($c->request->param('Flight2'));

    $c->stash(
        form     => $self->load_add_form($c),
        template => 'backoffice/itinerary/itinerary_form_RT.tt2',
        timetable1 => $timetable1,
        timetable2 => $timetable2,
    );
}

sub insert {
    my ($self, $c) = @_;

    my $timetable1 = $c->request->param('Flight1');
    my $timetable2 = $c->request->param('Flight2');
    my $fare_class = $c->request->param('fare_class_id');
    my $cost       = $c->request->param('cost');

    $c->stash(
        template => ($timetable2) ? 'backoffice/itinerary/itinerary_form_RT.tt2'
                                  : 'backoffice/itinerary/itinerary_form_OW.tt2'
    );

    eval {
        my $route1 = $c->model('Itinerary')->new(
            is_published    => ENABLE,
            timetable_id    => $timetable1,
            fare_class_id   => $fare_class,
            parent_id       => 0,
            cost            => $cost
        );
        my $new_route = $route1->create();

        if ($timetable2) {
            my $route2 = $c->model('Itinerary')->new(
                is_published  => ENABLE,
                timetable_id  => $timetable2,
                fare_class_id => $fare_class,
                parent_id     => $new_route->id,
                cost          => 0
            );

            $route2->create();
        }

        $c->stash(itinerary => $new_route);
        $self->setup_stash_from_data($c);

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
}

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        template => $self->setup_edit_template($c),
        form     => $self->load_upd_form($c),
    );
};

sub update :Private {
    my ($self, $c) = @_;

    my $fare_class =
        $c->request->param('fare_class_id');

    my $cost =
        $c->request->param('cost');

    eval {
        my $route1 = $c->model('Itinerary')->new(
            id              => $c->stash->{'itinerary'}->id,
            timetable_id    => $c->stash->{'itinerary'}->timetable_id,
            fare_class_id   => $fare_class,
            parent_id       => 0,
            cost            => $cost,
            is_published    => $c->stash->{'itinerary'}->is_published,
        );
        my $segment = $route1->update();
        my $next = $segment->next_route();
        if ($next) {
            $next->update({
                fare_class_id => $fare_class,
                cost          => 0,
                is_published  => $c->stash->{'itinerary'}->is_published,
            });
        }

        $self->setup_edit_template($c, $segment);
        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
}

sub load_add_form :Private {
    my ($self, $c) = @_;

    $c->stash->{'current_model_instance'} =
        $c->model('FareClass')->schema()->resultset('FareClass');

    my $form = $self->form();
    $form->load_config_filestem('backoffice/itinerary_form');
    $form->get_element({ name => 'Flight1' })
         ->value( $c->stash->{'Flight1'} );
    $form->get_element({ name => 'Flight2' })
         ->value( $c->stash->{'Flight2'} );
    $form->process();

    return $form;
}

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $itinerary = $c->stash->{'itinerary'};

    my $form = $self->load_add_form($c);
    $form->get_element({ name => 'Flight1' })
            ->value($c->stash->{'Flight1'});
    $form->get_element({ name => 'Flight2' })
            ->value($c->stash->{'Flight2'});
    $form->get_element({ name => 'fare_class_id' })
            ->value($itinerary->fare_class_id);
    $form->get_element({ name => 'cost' })
            ->value($itinerary->cost);
    $form->process();

    return $form;
}

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    my $itinerary = $c->stash->{'itinerary'};
    $itinerary->update({ is_published => ENABLE });

    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    my $itinerary = $c->stash->{'itinerary'};
    $itinerary->update({ is_published => DISABLE });

    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    my $itinerary = $c->stash->{'itinerary'};
    $self->setup_request_from_stash($c);
    eval {
        my $segment = $itinerary->next_route();
        if ($segment) {
            $c->model('Itinerary')->delete($segment->id);
        }

        $c->model('Itinerary')->delete($itinerary->id);
        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;

    $c->detach('default');
};

sub process_error {
    my ($self, $c, $e) = @_;

    if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $c->stash( message => $e->message );
    } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $c->stash( message => $e->message );
    } else {
        $c->stash( message => $@ );
    }
};

sub successful_message {
    my ($self, $c) = @_;

    $c->stash( message => MESSAGE_OK );
};

sub setup_stash_from_request :Private {
    my ($self, $c) = @_;

    my @param = qw(CityOfDeparture1
                   CityOfArrival1
                   DateOfDeparture1
                   Flight1
                   CityOfDeparture2
                   CityOfArrival2
                   DateOfDeparture2
                   Flight2);

    $c->stash({$_ => $c->request->param($_)})
        foreach (@param);
};

sub setup_stash_from_data :Private {
    my ($self, $c) = @_;

    my $itinerary = $c->stash->{'itinerary'};
    my $next = $itinerary->next_route();

    $c->stash({
        Flight1  => $itinerary->timetable_id,
        Flight2  => ( $next ) ? $next->timetable_id : undef,
        timetable1 => $itinerary->timetable,
        timetable2 => ( $next ) ? $next->timetable : undef,

        CityOfDeparture1 => $itinerary->timetable->flight->departure_airport->city_id,
        CityOfArrival1   => $itinerary->timetable->flight->destination_airport->city_id,
        DateOfDeparture1 => $itinerary->timetable->departure_date,

        CityOfDeparture2 => ( $next ) ? $next->timetable->flight->departure_airport->city_id
                                      : undef,
        CityOfArrival2   => ( $next ) ? $next->timetable->flight->destination_airport->city_id
                                      : undef,
        DateOfDeparture2 => ( $next ) ? $next->timetable->departure_date
                                      : undef,
    });
}

sub setup_request_from_stash :Private {
    my ($self, $c) = @_;

    my @param = qw(CityOfDeparture1
                   CityOfArrival
                   DateOfDeparture1
                   Flight1
                   CityOfDeparture2
                   CityOfArrival2
                   DateOfDeparture2
                   Flight2);

    $c->request->param($_, $c->stash->{$_})
        foreach (@param);
};

sub setup_edit_template {
    my ($self, $c) = @_;

    my $itinerary = $c->stash->{'itinerary'};
    my $next = $itinerary->next_route();
    return $next ? 'backoffice/itinerary/itinerary_form_RT.tt2'
                 : 'backoffice/itinerary/itinerary_form_OW.tt2';

}

sub viewRT :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 = $c->request->param('CityOfDeparture1');
    my $cityOfDeparture2 = $c->request->param('CityOfDeparture2');
    my $cityOfArrival1 = $c->request->param('CityOfArrival1');
    my $cityOfArrival2 = $c->request->param('CityOfArrival2');

    if ($cityOfArrival1 && $cityOfArrival2 &&
        $cityOfDeparture1 && $cityOfDeparture2) {

        my $iterator = ClubSpain::Model::Itinerary->itineraries({
            cityOfDeparture => $cityOfDeparture1,
            cityOfArrival   => $cityOfArrival1,
            showHidden      => 1,
        }, {
            cityOfDeparture => $cityOfDeparture2,
            cityOfArrival   => $cityOfArrival2,
            showHidden      => 1,
        });
        $c->stash(iterator => $iterator);
    }

    $c->stash(template => 'backoffice/itinerary/itinerary_search_RT_simple.tt2');
}

sub viewOW :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture = $c->request->param('CityOfDeparture1');
    my $cityOfArrival   = $c->request->param('CityOfArrival1');

    if ($cityOfDeparture && $cityOfArrival) {
        my $iterator = ClubSpain::Model::Itinerary->itineraries({
            cityOfDeparture => $cityOfDeparture,
            cityOfArrival   => $cityOfArrival,
            showHidden      => 1,
        });

        $c->stash(iterator => $iterator);
    }

    $c->stash(template => 'backoffice/itinerary/itinerary_search_OW_simple.tt2');
}

1;
