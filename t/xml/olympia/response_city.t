use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::City');
use_ok('ClubSpain::XML::Olympia::Response::City');

my @expect = map new ClubSpain::XML::Olympia::City($_),
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 11', Poblacion_Nombre => 'BENALMADENA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 13', Poblacion_Nombre => 'ESTEPONA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 14', Poblacion_Nombre => 'FUENGIROLA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 16', Poblacion_Nombre => 'MANILVA'  },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 17', Poblacion_Nombre => 'MARBELLA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 18', Poblacion_Nombre => 'NERJA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 20', Poblacion_Nombre => 'RINCON DE LA VICTORIA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 22', Poblacion_Nombre => 'SAN PEDRO DE ALCANTARA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 23', Poblacion_Nombre => 'TORRE DEL MAR'  },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 24', Poblacion_Nombre => 'TORREMOLINOS'  },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 27', Poblacion_Nombre => 'MALAGA' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 39', Poblacion_Nombre => 'MIJAS' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => ' 46', Poblacion_Nombre => 'TORROX' },
      { Pais_Codigo => '00034', Provincia_Codigo => '029', Poblacion_Codigo => 'B01', Poblacion_Nombre => 'CORTES DE LA FRONTERA' };


my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::City->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Poblaciones>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 11</Poblacion_Codigo>
        <Poblacion_Nombre>BENALMADENA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 13</Poblacion_Codigo>
        <Poblacion_Nombre>ESTEPONA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 14</Poblacion_Codigo>
        <Poblacion_Nombre>FUENGIROLA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 16</Poblacion_Codigo>
        <Poblacion_Nombre>MANILVA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 17</Poblacion_Codigo>
        <Poblacion_Nombre>MARBELLA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 18</Poblacion_Codigo>
        <Poblacion_Nombre>NERJA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 20</Poblacion_Codigo>
        <Poblacion_Nombre>RINCON DE LA VICTORIA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 22</Poblacion_Codigo>
        <Poblacion_Nombre>SAN PEDRO DE ALCANTARA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 23</Poblacion_Codigo>
        <Poblacion_Nombre>TORRE DEL MAR</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 24</Poblacion_Codigo>
        <Poblacion_Nombre>TORREMOLINOS</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 27</Poblacion_Codigo>
        <Poblacion_Nombre>MALAGA</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 39</Poblacion_Codigo>
        <Poblacion_Nombre>MIJAS</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo> 46</Poblacion_Codigo>
        <Poblacion_Nombre>TORROX</Poblacion_Nombre>
      </Poblacion>
      <Poblacion>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Poblacion_Codigo>B01</Poblacion_Codigo>
        <Poblacion_Nombre>CORTES DE LA FRONTERA</Poblacion_Nombre>
      </Poblacion>
    </Poblaciones>
  </Respuesta>
</string>


}
