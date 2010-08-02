use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::PictogramPB');
use_ok('ClubSpain::XML::Olympia::Response::PictogramPB');

my @expect = map new ClubSpain::XML::Olympia::PictogramPB($_),
    { Codigo => "1", Descripcion => "PISCINA", Url => "http://89.140.26.66/Simbolos/Piscina.gif" },
    { Codigo => "10", Descripcion => "BALCON", Url => "http://89.140.26.66/Simbolos/Balcon.gif" },
    { Codigo => "11", Descripcion => "BAOO COMPLETO", Url => "http://89.140.26.66/Simbolos/BanoCompleto.gif" },
    { Codigo => "115", Descripcion => "SALON DE CONVENCIONES", Url => "http://89.140.26.66/Simbolos/SalonConvenciones.gif" },
    { Codigo => "12", Descripcion => "BAR", Url => "http://89.140.26.66/Simbolos/Bar.gif" },
    { Codigo => "13", Descripcion => "BUFFET", Url => "http://89.140.26.66/Simbolos/Buffet.gif" },
    { Codigo => "14", Descripcion => "CALEFACCION", Url => "http://89.140.26.66/Simbolos/Calefaccion.gif" },
    { Codigo => "2", Descripcion => "MINIBAR", Url => "http://89.140.26.66/Simbolos/Minibar.gif" },
    { Codigo => "26", Descripcion => "GARAJE", Url => "http://89.140.26.66/Simbolos/Garaje.gif" },
    { Codigo => "27", Descripcion => "GIMNASIO", Url => "http://89.140.26.66/Simbolos/Gimnasio.gif" },
    { Codigo => "28", Descripcion => "INTERNET", Url => "http://89.140.26.66/Simbolos/Internet.gif" },
    { Codigo => "38", Descripcion => "PELUQUEROA", Url => "http://89.140.26.66/Simbolos/Peluqueria.gif" },
    { Codigo => "39", Descripcion => "PISCINA CUBIERTA", Url => "http://89.140.26.66/Simbolos/PiscinaCubierta.gif" },
    { Codigo => "4", Descripcion => "CAJA FUERTE", Url => "http://89.140.26.66/Simbolos/CajaFuerte.gif" },
    { Codigo => "40", Descripcion => "PLAYA", Url => "http://89.140.26.66/Simbolos/Playa.gif" },
    { Codigo => "42", Descripcion => "AIRE ACONDICIONADO", Url => "http://89.140.26.66/Simbolos/Refrigeracion.gif" },
    { Codigo => "44", Descripcion => "SECADOR", Url => "http://89.140.26.66/Simbolos/Secador.gif" },
    { Codigo => "49", Descripcion => "TELOFONO", Url => "http://89.140.26.66/Simbolos/Telefono.gif" },
    { Codigo => "51", Descripcion => "TIENDAS", Url => "http://89.140.26.66/Simbolos/Tiendas.gif" },
    { Codigo => "54", Descripcion => "TELEVISION SATOLITE", Url => "http://89.140.26.66/Simbolos/TVSatelite.gif" },
    { Codigo => "56", Descripcion => "ALQUILER DE BICICLETAS", Url => "http://89.140.26.66/Simbolos/BICIS.gif" },
    { Codigo => "59", Descripcion => "MINIGOLF", Url => "http://89.140.26.66/Simbolos/MINIGOLF.gif" },
    { Codigo => "60", Descripcion => "ANIMACION", Url => "http://89.140.26.66/Simbolos/ANIMACION.gif" },
    { Codigo => "65", Descripcion => "CAFETEROA", Url => "http://89.140.26.66/Simbolos/CAFETERIA.gif" },
    { Codigo => "71", Descripcion => "PISCINA INFANTIL", Url => "http://89.140.26.66/Simbolos/PiscinaInfantil.gif" },
    { Codigo => "78", Descripcion => "HAMACAS", Url => "http://89.140.26.66/Simbolos/Hamacas.gif" },
    { Codigo => "79", Descripcion => "TOALLAS PISCINA", Url => "http://89.140.26.66/Simbolos/ToallasPiscina.gif" },
    { Codigo => "81", Descripcion => "SHOW COOKING", Url => "http://89.140.26.66/Simbolos/ShowCooking.gif" },
    { Codigo => "86", Descripcion => "MINICLUB", Url => "http://89.140.26.66/Simbolos/MiniClub.gif" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::PictogramPB->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Simbolos>
      <Simbolo>
        <Codigo>1</Codigo>
        <Descripcion>PISCINA</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Piscina.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>10</Codigo>
        <Descripcion>BALCON</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Balcon.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>11</Codigo>
        <Descripcion>BAOO COMPLETO</Descripcion>
        <Url>http://89.140.26.66/Simbolos/BanoCompleto.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>115</Codigo>
        <Descripcion>SALON DE CONVENCIONES</Descripcion>
        <Url>http://89.140.26.66/Simbolos/SalonConvenciones.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>12</Codigo>
        <Descripcion>BAR</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Bar.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>13</Codigo>
        <Descripcion>BUFFET</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Buffet.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>14</Codigo>
        <Descripcion>CALEFACCION</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Calefaccion.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>2</Codigo>
        <Descripcion>MINIBAR</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Minibar.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>26</Codigo>
        <Descripcion>GARAJE</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Garaje.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>27</Codigo>
        <Descripcion>GIMNASIO</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Gimnasio.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>28</Codigo>
        <Descripcion>INTERNET</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Internet.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>38</Codigo>
        <Descripcion>PELUQUEROA</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Peluqueria.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>39</Codigo>
        <Descripcion>PISCINA CUBIERTA</Descripcion>
        <Url>http://89.140.26.66/Simbolos/PiscinaCubierta.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>4</Codigo>
        <Descripcion>CAJA FUERTE</Descripcion>
        <Url>http://89.140.26.66/Simbolos/CajaFuerte.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>40</Codigo>
        <Descripcion>PLAYA</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Playa.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>42</Codigo>
        <Descripcion>AIRE ACONDICIONADO</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Refrigeracion.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>44</Codigo>
        <Descripcion>SECADOR</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Secador.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>49</Codigo>
        <Descripcion>TELOFONO</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Telefono.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>51</Codigo>
        <Descripcion>TIENDAS</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Tiendas.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>54</Codigo>
        <Descripcion>TELEVISION SATOLITE</Descripcion>
        <Url>http://89.140.26.66/Simbolos/TVSatelite.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>56</Codigo>
        <Descripcion>ALQUILER DE BICICLETAS</Descripcion>
        <Url>http://89.140.26.66/Simbolos/BICIS.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>59</Codigo>
        <Descripcion>MINIGOLF</Descripcion>
        <Url>http://89.140.26.66/Simbolos/MINIGOLF.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>60</Codigo>
        <Descripcion>ANIMACION</Descripcion>
        <Url>http://89.140.26.66/Simbolos/ANIMACION.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>65</Codigo>
        <Descripcion>CAFETEROA</Descripcion>
        <Url>http://89.140.26.66/Simbolos/CAFETERIA.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>71</Codigo>
        <Descripcion>PISCINA INFANTIL</Descripcion>
        <Url>http://89.140.26.66/Simbolos/PiscinaInfantil.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>78</Codigo>
        <Descripcion>HAMACAS</Descripcion>
        <Url>http://89.140.26.66/Simbolos/Hamacas.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>79</Codigo>
        <Descripcion>TOALLAS PISCINA</Descripcion>
        <Url>http://89.140.26.66/Simbolos/ToallasPiscina.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>81</Codigo>
        <Descripcion>SHOW COOKING</Descripcion>
        <Url>http://89.140.26.66/Simbolos/ShowCooking.gif</Url>
      </Simbolo>
      <Simbolo>
        <Codigo>86</Codigo>
        <Descripcion>MINICLUB</Descripcion>
        <Url>http://89.140.26.66/Simbolos/MiniClub.gif</Url>
      </Simbolo>
    </Simbolos>
  </Respuesta>
</string>

}
