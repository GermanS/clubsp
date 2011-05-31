package ClubSpain::Controller::Charter;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template  => 'common/charter/itinerary_search_RT_simple.tt2'
    );
}

sub default :Path {
    my ($self, $c, $direction) = @_;

    my ($codeOfDeparture, $codeOfArrival) = split('-', $direction);
    if ($codeOfDeparture && $codeOfArrival) {
        my $cityOfDeparture = $c->model('City')->search({ iata => $codeOfDeparture, is_published => 1 })->single;
        my $cityOfArrival   = $c->model('City')->search({ iata => $codeOfArrival,   is_published => 1 })->single;

        if ($cityOfArrival && $cityOfDeparture) {
            my $iterator = $c->model('Itinerary')->itineraries({
                cityOfDeparture => $cityOfDeparture->id,
                cityOfArrival   => $cityOfArrival->id
            }, {
                cityOfDeparture => $cityOfArrival->id,
                cityOfArrival   => $cityOfDeparture->id
            });

            $c->stash(
                iterator => $iterator,

                cityOfDeparture1 => $cityOfDeparture,
                cityOfArrival1   => $cityOfArrival,
                cityOfDeparture2 => $cityOfArrival,
                cityOfArrival2   => $cityOfDeparture,

                CityOfDeparture1 => $cityOfDeparture->id,
                CityOfArrival1   => $cityOfArrival->id,
                CityOfDeparture2 => $cityOfArrival->id,
                CityOfArrival2   => $cityOfDeparture->id
            );
        }
    }
}

sub base :Chained('/charter') :PathPart('') :CaptureArgs(0) { }

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

#    my $article;
#    eval {
#        $article = $c->model('Article')->fetch_by_id($id);
#        $c->stash( article => $article );
#    };

#    if ($@) {
#        $c->response->redirect($c->uri_for($self->action_for('index')));
#        $c->detach();
#    }
}

sub searchRT :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival1   = $c->stash->{'CityOfArrival1'};
    my $dateOfDeparture1 = $c->stash->{'DateOfDeparture1'};

    my $cityOfDeparture2 = $c->stash->{'CityOfDeparture2'};
    my $cityOfArrival2   = $c->stash->{'CityOfArrival2'};
    my $dateOfDeparture2 = $c->stash->{'DateOfDeparture2'};

    if ($cityOfArrival1 && $cityOfDeparture1 && $dateOfDeparture1 &&
        $cityOfArrival2 && $cityOfDeparture2 && $dateOfDeparture2) {

        my $iterator = $c->model('Itinerary')->itineraries({
                cityOfDeparture => $cityOfDeparture1,
                cityOfArrival   => $cityOfArrival1,
                dateOfDeparture => $dateOfDeparture1
            }, {
                cityOfDeparture => $cityOfDeparture2,
                cityOfArrival   => $cityOfArrival2,
                dateOfDeparture => $dateOfDeparture2
        });

        $c->stash( iterator => $iterator );
    }

    $c->stash(template => 'common/charter/itinerary_search_RT.tt2');
}

sub searchOW :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival   = $c->stash->{'CityOfArrival1'};
    my $dateOfDeparture = $c->stash->{'DateOfDeparture1'};

    if ($cityOfDeparture && $cityOfArrival && $dateOfDeparture) {
        my $iterator = $c->model('Itinerary')->itineraries({
            cityOfDeparture => $cityOfDeparture,
            cityOfArrival   => $cityOfArrival,
            dateOfDeparture => $dateOfDeparture
        });

        $c->stash(
            iterator => $iterator,

            CityOfDeparture1 => $cityOfDeparture,
            CityOfArrival1   => $cityOfArrival,
            DateOfDeparture1 => $dateOfDeparture
        );
    }

    $c->stash(template => 'common/charter/itinerary_search_OW.tt2');
}

sub viewRT :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival1   = $c->stash->{'CityOfArrival1'};
    my $cityOfDeparture2 = $c->stash->{'CityOfDeparture2'};
    my $cityOfArrival2   = $c->stash->{'CityOfArrival2'};

    if ($cityOfDeparture1 && $cityOfArrival1 &&
        $cityOfDeparture2 && $cityOfArrival2) {

        my $iterator = ClubSpain::Model::Itinerary->itineraries({
            cityOfDeparture => $cityOfDeparture1,
            cityOfArrival   => $cityOfArrival1
        }, {
            cityOfDeparture => $cityOfDeparture2,
            cityOfArrival   => $cityOfArrival2
        });

        $c->stash(iterator => $iterator);
    }

    $c->stash(template => 'common/charter/itinerary_search_RT_simple.tt2');
}

sub viewOW :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival1   = $c->stash->{'CityOfArrival1'};

    if ($cityOfDeparture1 && $cityOfArrival1) {

        my $iterator = $c->model('Itinerary')->itineraries({
            cityOfDeparture => $cityOfDeparture1,
            cityOfArrival   => $cityOfArrival1
        });

        $c->stash(iterator => $iterator);
    }

    $c->stash(template => 'common/charter/itinerary_search_OW_simple.tt2');
}

sub end :ActionClass('RenderView') {}

sub setup_stash_from_request {
    my ($self, $c) = @_;

    my @param = qw(CityOfDeparture1
                   CityOfArrival1
                   CityOfDeparture2
                   CityOfArrival2);

    $c->stash({ $_ => $c->request->param($_)})
        foreach (@param, qw(DateOfDeparture1 DateOfDeparture2));

    $c->stash({
        lcfirst $_ => $c->stash->{$_} ? $c->model('City')->fetch_by_id($c->stash->{$_}) : undef
    }) foreach (@param);
}

1;
