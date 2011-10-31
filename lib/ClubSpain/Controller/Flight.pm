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

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template  => 'common/flight/flight.tt2'
    );
}

sub base :Chained('/flight') :PathPart('') :CaptureArgs(0) {
}

sub end :ActionClass('RenderView') {
}

sub default :Path {
}

sub search :Local {
    my ($self, $c) = @_;

    my $seat = ClubSpain::XML::VipService::Seat->new(
        passenger => 'ADULT',
        count     => 1
    );

    my $cityOfDeparture1 = ClubSpain::XML::VipService::Location->new(
        code => 'MOW',
        name => 'Moscow'
    );
    my $cityOfArrival1 = ClubSpain::XML::VipService::Location->new(
        code => 'BCN',
        name => 'barcelona'
    );
    my $cityOfDeparture2 = ClubSpain::XML::VipService::Location->new(
        code => 'BCN',
        name => 'Barcelona'
    );
    my $cityOfArrival2 = ClubSpain::XML::VipService::Location->new(
        code => 'MOW',
        name => 'Moscow'
    );

    my $date1 = DateTime->new( year => 2012, month => 01, day => 21 );
    my $date2 = DateTime->new( year => 2012, month => 01, day => 28 );

    my $route1 = ClubSpain::XML::VipService::Route->new(
        date          => $date1, #'2012-01-21',
        locationBegin => $cityOfDeparture1,
        locationEnd   => $cityOfArrival1,
    );
    my $route2 = ClubSpain::XML::VipService::Route->new(
        date          => $date2, #'2012-01-28',
        locationBegin => $cityOfDeparture2,
        locationEnd   => $cityOfArrival2,
    );

    my $flight = ClubSpain::XML::VipService::Flight->new(
        route => [ $route1, $route2 ],
        seat  => [ $seat ]
    );

    my $config = ClubSpain::XML::VipService::Config->new(
        locale              => 'ru', #TODO: get rid of this
        loginName           => 'dummy_loginname', #TODO: get rid of this
        password            => 'dummy_password', #TODO: get rid of this
        salesPointCode      => 'dummy_salesPointCode', #TODO: get rid of this
        corporateClientCode => 'dummy_corporateClientCode',
        wsdlfile            => 'root/vipservice/vip_service.wsdl',
        xsdfile             => 'root/vipservice/vip_service.xsd',
    );
    my $service = ClubSpain::XML::VipService->new(config => $config);
    my $result = $service->searchFlights($flight);

    $c->stash( result => $result );
}

1;
