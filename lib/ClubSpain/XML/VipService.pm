package ClubSpain::XML::VipService;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use ClubSpain::XML::VipService::Config;
use ClubSpain::XML::VipService::Response::FlightSearch;

use XML::Compile::SOAP11;
use XML::Compile::Transport::SOAPHTTP;
use XML::Compile::WSDL11;

use Moose;

has 'config' => (
    is       => 'ro',
    isa      => 'ClubSpain::XML::VipService::Config',
    required => 1,
);

has 'wsdl' => (
    is  => 'rw',
    isa => 'XML::Compile::WSDL11',
);

sub BUILD {
    my ($self, $args) = @_;

    my $wsdl = XML::Compile::WSDL11 -> new($self -> config -> wsdlfile );
    $wsdl -> importDefinitions( $self -> config -> xsdfile );

    $self -> wsdl( $wsdl );
}

sub searchFlights {
    my ($self, $criteria) = @_;

    my $searchFlights = $self -> wsdl -> compileClient( 'searchFlights', validate => 1 );
    my ($answer, $trace) = $searchFlights -> (
        parameters => {
            context    => $self -> config -> to_hash(),
            parameters => $criteria -> to_hash(),
        }
    );

    use ClubSpain::XML::VipService::Dump;
    my $dump = ClubSpain::XML::VipService::Dump -> new(
        date_of_departure    => $criteria -> route() -> [ 0 ] -> date() -> ymd(),
        date_of_arrival      => $criteria -> route() -> [ 1 ] -> date() -> ymd(),
        airport_of_departure => $criteria -> route() -> [ 0 ] -> locationBegin() -> code(),
        airport_of_arrival   => $criteria -> route() -> [ 1 ] -> locationBegin() -> code(),
        content              => $trace -> response() -> content(),
    );
    $dump -> save();

    return ClubSpain::XML::VipService::Response::FlightSearch -> new(
        request  => $criteria,
        response => $answer
    );
}

__PACKAGE__ -> meta -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::XML::VipService

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FIELDS

=head2 config

=head2 wsdl

=head1 METHODS

=head2 searchFlights($flight_criteria)

Поиск авиабилета по указаным критериям
На входе:
    $flight_criteria - Объект типа VipService::Flight

=head1 SEE ALSO

L<Moose>
L<XML::Compile>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut