package ClubSpain::XML::VipService;
use namespace::autoclean;
use Moose;
use ClubSpain::XML::VipService::Config;
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


=head2 searchFlights(%params)

Поиск авиабилета по указаным критериям.

На входе:
=cut

sub searchFlights {
    my ($self, %params) = @_;

    my $searchFlights = $self->wsdl->compileClient('searchFlights');
    my ($answer, $trace) = $searchFlights->(
        $self->config->context_hash(),

    );

    return $answer;
}


__PACKAGE__->meta->make_immutable();

1;
