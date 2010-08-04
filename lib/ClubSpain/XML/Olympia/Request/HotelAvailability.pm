package ClubSpain::XML::Olympia::Request::HotelAvailability;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ( $self, %params ) = @_;

    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');

    my $root = $doc->createElement('DevuelveDisponibilidadPB');
    $root->setAttribute('xmlns', 'http://tempuri.org/');

    my $user = $doc->createElement('User');
    $user->appendText($params{'user'})
        if defined $params{'user'};

    my $password = $doc->createElement('password');
    $password->appendText($params{'password'})
        if defined $params{'password'};

    my $pais = $doc->createElement('Pais');
    $pais->appendText($params{'pais'})
        if defined $params{'pais'};

    my $provincia = $doc->createElement('provincia');
    $provincia->appendText($params{'provincia'})
        if defined $params{'provincia'};

    my $poblacion = $doc->createElement('Poblacion');
    $poblacion->appendText($params{'poblacion'})
        if defined $params{'poblacion'};

    my $categoria = $doc->createElement('Categoria');
    $categoria->appendText($params{'categoria'})
        if defined $params{'categoria'};

    my $codigo = $doc->createElement('Codigo');
    $codigo->appendText($params{'codigo'})
        if defined $params{'codigo'};

    my $fechaentradast = $doc->createElement('FechaEntradaSt');
    $fechaentradast->appendText($params{'fechaentradast'})
        if defined $params{'fechaentradast'};

    my $noches = $doc->createElement('Noches');
    $noches->appendText($params{'noches'})
        if defined $params{'noches'};

    my $listhab           = $doc->createElement('ListHab');
    my $habitaciones_list = $doc->createElement('HabitacionesList');
    my $habitacion        = $doc->createElement('Habitacion');
    $habitacion->setAttribute('Ord', $params{'rooms'})
        if defined $params{'rooms'};

    my $adultos = $doc->createElement('Adultos');
    $adultos->appendText($params{'adultos'})
        if defined $params{'adultos'};

    my $ninos = $doc->createElement('ninos');
    if (defined $params{'ninos'}) {
        $ninos->setAttribute('num', scalar @{$params{'ninos'}});

        foreach my $age (@{$params{'ninos'}}) {
            my $edad = $doc->createElement('edad');
            $edad->appendText($age);
            $ninos->appendChild($edad);
        }
    }

    my $regimen = $doc->createElement('Regimen');
    $regimen->appendText($params{'regimen'})
        if defined $params{'regimen'};

    $habitacion->appendChild($adultos);
    $habitacion->appendChild($ninos);
    $habitacion->appendChild($regimen);

    $habitaciones_list->appendChild($habitacion);
    $listhab->appendChild($habitaciones_list);

    my $opciones = $doc->createElement('Opciones');

    $root->appendChild($user);
    $root->appendChild($password);
    $root->appendChild($pais);
    $root->appendChild($provincia);
    $root->appendChild($poblacion);
    $root->appendChild($categoria);
    $root->appendChild($codigo);
    $root->appendChild($fechaentradast);
    $root->appendChild($noches);
    $root->appendChild($listhab);
    $root->appendChild($opciones);

    $doc->setDocumentElement($root);

    return $doc->toString(1);
}

1;
