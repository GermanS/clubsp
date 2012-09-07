package ClubSpain::Controller::BackOffice::Fare;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Constants qw(:all);

use ClubSpain::Form::BackOffice::Itinerary;
sub form :Private {
    my ($self, $listener) = @_;

    return ClubSpain::Form::BackOffice::Itinerary->new({
        listeners => [ $listener ]
    })
};

has 'template'
    => ( is => 'ro', default => 'backoffice/itinerary/itinerary_search_RT.tt2' );
has 'model'
    => ( is => 'ro', default => 'Itinerary' );

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
                push @route, $route->id if $_ == $route->id;
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

sub base :Chained('/backoffice/base') :PathPart('fare') :CaptureArgs(0) {}

sub searchOW :Local {
    my ($self, $c) = @_;

    $c->stash( template => 'backoffice/itinerary/itinerary_search_OW.tt2' );
    $c->detach('default');
};

sub createOW :Local {
    my ($self, $c) = @_;
    $self->_create($c);
    $c->stash( template => 'backoffice/itinerary/itinerary_form_OW.tt2' );
};

sub createRT :Local {
    my ($self, $c) = @_;
    $self->_create($c);
    $c->stash( template   => 'backoffice/itinerary/itinerary_form_RT.tt2' );
};

sub _create :Private {
    my ($self, $c) = @_;
    $self->setup_stash_from_request($c);

    my $fare = $c->model($self->model)->new();
    my $form = $self->form($fare);

    my $is_posted = exists ($c->request->parameters->{'fare_class_id'});
    $form->process(
        posted => $is_posted,
        init_object => {
            Flight1 => $c->request->param('Flight1'),
            Flight2 => $c->request->param('Flight2'),
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $fare->set_enable();

        eval {
            my $object = $fare->insert_fare();
            $c->stash( object => $object );
            $self->setup_stash_from_data($c);
        };
        $form->process_error($@) if $@;
    }

    my $timetable1;
    if ($c->request->param('Flight1')) {
       $timetable1 = $c->model('TimeTable')->fetch_by_id($c->request->param('Flight1'));
    }
    my $timetable2;
    if ($c->request->param('Flight2')) {
        $timetable2 = $c->model('TimeTable')->fetch_by_id($c->request->param('Flight2'));
    }
    $c->stash({
        form       => $form,
        timetable1 => $timetable1,
        timetable2 => $timetable2,
    });
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    $self->setup_stash_from_data($c);

    my $fare = $c->model($self->model)->new();
    my $form = $self->form($fare);
    my $return = ($self->get_object($c)->next_route())
        ?  $self->get_object($c)->next_route->timetable_id
        : 0;

    $form->process(
        init_object => {
            Flight1         => $self->get_object($c)->timetable_id,
            Flight2         => $return,
            fare_class_id   => $self->get_object($c)->fare_class_id,
            cost            => $self->get_object($c)->cost,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $fare->set_id(
            $self->get_object($c)->id
        );
        $fare->set_is_published(
            $self->get_object($c)->is_published
        );

        eval { $fare->update_fare(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form => $form,
        template => $self->setup_edit_template($c)
    );
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    my $itinerary = $self->get_object($c);;
    $itinerary->update({ is_published => ENABLE });

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    my $itinerary = $self->get_object($c);;
    $itinerary->update({ is_published => DISABLE });

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);

    eval { $c->model($self->model)->delete_fare( $self->get_object($c)->id ); };
    $self->show_message(context => $c, error => $@);

    $c->detach('default');
}

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

    $c->stash({ $_ => $c->request->param($_) || '' })
        foreach (@param);
};

sub setup_stash_from_data :Private {
    my ($self, $c) = @_;

    my $itinerary = $self->get_object($c);
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

    return
        $self->get_object($c)->next_route()
            ? 'backoffice/itinerary/itinerary_form_RT.tt2'
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

__PACKAGE__->meta->make_immutable();

1;
