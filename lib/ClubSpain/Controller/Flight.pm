package ClubSpain::Controller::Flight;
use strict;
use warnings;
use utf8;
use parent qw(Catalyst::Controller);
use ClubSpain::XML::VipService::Seat;
use ClubSpain::XML::VipService::Location;
use ClubSpain::XML::VipService::Route;
use ClubSpain::XML::VipService::Flight;
use ClubSpain::XML::VipService;
use ClubSpain::XML::VipService::Config;
use DateTime;
use DateTime::Format::Strptime;

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template  => 'common/flight/flight.tt2'
    );
}

sub base :Chained('/flight') :PathPart('') :CaptureArgs(0) {
}

sub end :ActionClass('RenderView') {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);
}

sub default :Path {
}

sub search :Local {
    my ($self, $c) = @_;

    my $flight;

    eval {
        my $city_of_departure = $c->model('City')->fetch_by_id(
            $c->request->param('CityOfDeparture_id')
        );
        my $city_of_arrival = $c->model('City')->fetch_by_id(
            $c->request->param('CityOfArrival_id')
        );
        my $cityOfDeparture = ClubSpain::XML::VipService::Location->new(
            code => $city_of_departure->iata,
            name => $city_of_departure->name,
        );
        my $cityOfArrival = ClubSpain::XML::VipService::Location->new(
            code => $city_of_arrival->iata,
            name => $city_of_arrival->name,
        );

        my $format = DateTime::Format::Strptime->new(
            locale  => 'ru_RU',
            pattern => '%d-%m-%Y',
        );
        my $dateOfDeparture1 = $format->parse_datetime(
            $c->request->param('DateOfDeparture1')
        );
        my $dateOfDeparture2;
        if ($c->request->param('DateOfDeparture2')) {
            $dateOfDeparture2 = $format->parse_datetime(
                $c->request->param('DateOfDeparture2')
            );
        }

        my @seat = ();
        my %values = (
            'ADULT'  => 'adults_data',
            'CHILD'  => 'children_data',
            'INFANT' => 'infants_data',
        );
        while ( my ($key, $value) = each %values) {
            my $count = $c->request->param($value);
            push @seat, ClubSpain::XML::VipService::Seat->new(
                passenger => $key,
                count     => $count,
            ) if $count;
        }

        my @route;
        push @route, ClubSpain::XML::VipService::Route->new(
            date          => $dateOfDeparture1,
            locationBegin => $cityOfDeparture,
            locationEnd   => $cityOfArrival,
        );
        push @route, ClubSpain::XML::VipService::Route->new(
            date          => $dateOfDeparture2,
            locationBegin => $cityOfArrival,
            locationEnd   => $cityOfDeparture,
        ) if $dateOfDeparture2;

        $flight = ClubSpain::XML::VipService::Flight->new(
            serviceClass => $c->request->param('cabin_data'),
            route => \@route,
            seat  => \@seat
        );
    };

    if ($@) {
        $c->stash(
            message => ClubSpain::Message->error( 'Произошла ошибка. Попробуйте еще раз!' )
        );
        return;
    }

    my $config = ClubSpain::XML::VipService::Config->new( config => $c->config );
    my $service = ClubSpain::XML::VipService->new(config => $config);
    my $result = $service->searchFlights($flight);

    $c->stash( result => $result );
}

sub setup_stash_from_request : Private {
    my ($self, $c) = @_;

    my %result = ();

    my @values = qw(
        adults_data
        children_data
        infants_data
        cabin_data
        CityOfArrival
        CityOfArrival_id
        CityOfDeparture
        CityOfDeparture_id
        DateOfDeparture1
        DateOfDeparture2
        search_mode
    );
    for my $value (@values) {
        $result{$value} = $c->request->param($value) || 0;
    }

    #set adults default to 1
    $result{'adults_data'} = 1
        unless $result{'adults_data'};

    #set cabin default to 'ECONOMY'
    $result{'cabin_data'} = 'ECONOMY'
        unless $result{'cabin_data'};

    #set dates of departure to undef
    for my $date (qw(DateOfDeparture1 DateOfDeparture2)) {
        $result{$date} = ''
            unless $result{$date};
    }

    #set cities defaults to undef
    for my $city qw(CityOfArrival CityOfDeparture) {
        $result{$city} = ''
            unless $result{$city}
    }

    #set search mode to RT
    $result{'search_mode'} = 'RT'
        unless $result{'search_mode'};

    #seo pupruse. set the title of the page to direction
    if ($c->request->param('CityOfDeparture_id') && $c->request->param('CityOfArrival_id')) {
        my $city_of_departure = $c->model('City')->fetch_by_id(
            $c->request->param('CityOfDeparture_id')
        );
        my $city_of_arrival = $c->model('City')->fetch_by_id(
            $c->request->param('CityOfArrival_id')
        );
        $result{'title'} = $c->model('SEO::Itinerary')->simple_direction_title(
            cityOfDeparture => $city_of_departure,
            cityOfArrival   => $city_of_arrival,
        );
    }

    #set default city of departure to MOW
    unless ($result{'CityOfDeparture'} && $result{'CityOfDeparture_id'} ) {
        $result{'CityOfDeparture_id'} = 1;

        my $mow = $c->model('City')->fetch_by_id($result{'CityOfDeparture_id'});
        $result{'CityOfDeparture'} = sprintf("%s (%s)", $mow->name_ru, $mow->iata);
    }

    $c->stash({%result});
}

1;
