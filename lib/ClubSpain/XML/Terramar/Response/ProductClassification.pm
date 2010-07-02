package ClubSpain::XML::Terramar::Response::ProductClassification;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::ProductClassification;

sub parse {
    my ( $self, $xml_sting ) = @_;
    
    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();
    
    my $xpath         = new XML::LibXML::XPathExpression('/integracion/superclase');    
    my $xpath_id      = new XML::LibXML::XPathExpression('id_tipo_articulo_superclase');
    my $xpath_nombre  = new XML::LibXML::XPathExpression('nombre');
    my $xpath_orden   = new XML::LibXML::XPathExpression('orden');  
    
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {        
        my $lang = ClubSpain::XML::Terramar::ProductClassification->new({
            id_tipo_articulo_superclase     => $node->findvalue($xpath_id),
            nombre   => $node->findvalue($xpath_nombre),
            orden    => $node->findvalue($xpath_orden),
        });
       
        push @res, $lang;
    }
    
    return \@res;
}

1;

=head 

<integracion accion="listado_superclases">
  <superclase>
     <id_tipo_articulo_superclase>1</id_tipo_articulo_superclase>
     <nombre>Estancias</nombre>
     <orden>2</orden>
  </superclase>
  <superclase>
    <id_tipo_articulo_superclase>2</id_tipo_articulo_superclase>
    <nombre>Nieve</nombre>
    <orden>9</orden>
  </superclase>
  <superclase_predeterminada>1</superclase_predeterminada>
</integracion>

=cut

