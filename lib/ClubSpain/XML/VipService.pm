package ClubSpain::XML::VipService;
use namespace::autoclean;
use Moose;
use ClubSpain::XML::VipService::Config;
use ClubSpain::XML::VipService::Response::FlightSearch;
use XML::Compile::WSDL11;
use XML::Compile::SOAP11;
use XML::Compile::Transport::SOAPHTTP;

has 'config' => (
    is       => 'ro',
    required => 1,
    isa      => 'ClubSpain::XML::VipService::Config'
);
has 'wsdl' => (
    is => 'rw'
);

sub BUILD {
    my ($self, $args) = @_;

    my $wsdl = XML::Compile::WSDL11->new($self->config->wsdlfile);
    $wsdl->importDefinitions($self->config->xsdfile);

    $self->wsdl($wsdl);
}


=head2 searchFlights($flight_criteria)

Поиск авиабилета по указаным критериям.

На входе:

    $flight_criteria - Объект типа VipService::Flight

=cut

sub searchFlights {
    my ($self, $criteria) = @_;

    my $searchFlights = $self->wsdl->compileClient('searchFlights', validate => 1);
    my ($answer, $trace) = $searchFlights->(
        parameters => {
#            context    => $self->config->to_hash(),
            context => {
                locale     => 'ru',
                loginName  => 'systema@vremiatour.ru',
                password   => 'systema@vremiatour.ru',
                salesPointCode => '001',
                corporateClientCode => 'VREMYA_TUR'
            },
            parameters => $criteria->to_hash(),
        }
    );

#    use Data::Dumper;
#    warn Dumper($trace);
#    use File::Slurp;
#    write_file('OUT_iberia.txt', Dumper($answer));
#    warn Dumper($answer);
#    warn $trace->printResponse;

    return ClubSpain::XML::VipService::Response::FlightSearch->new(
        request  => $criteria,
        response => $answer
    );
}


__PACKAGE__->meta->make_immutable();

1;
