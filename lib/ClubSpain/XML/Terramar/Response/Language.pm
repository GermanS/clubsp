package ClubSpain::XML::Terramar::Response::Language;

use Moose;

use XML::LibXML;
use ClubSpain::XML::Terramar::Language;

sub parse {
    my ($self, $xml_sting) = @_;
    
    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();
    
    my $xpath               = new XML::LibXML::XPathExpression('/integracion/idioma');    
    my $xpath_id_idioma     = new XML::LibXML::XPathExpression('id_idioma');
    my $xpath_nombre_idioma = new XML::LibXML::XPathExpression('nombre_idioma');
    my $xpath_logo_idioma   = new XML::LibXML::XPathExpression('logo_idioma');    
    
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {        
        my $lang = ClubSpain::XML::Terramar::Language->new({
            id_idioma     => $node->findvalue($xpath_id_idioma),
            nombre_idioma => $node->findvalue($xpath_nombre_idioma),
            logo_idioma   => $node->findvalue($xpath_logo_idioma),
        });
       
        push @res, $lang;
    }
    
    return \@res;
}

1;
