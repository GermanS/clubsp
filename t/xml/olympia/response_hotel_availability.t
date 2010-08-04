use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::HotelAvailability');
use_ok('ClubSpain::XML::Olympia::Response::HotelAvailability');

my @expect = new ClubSpain::XML::Olympia::HotelAvailability({
    CodigoPeticion => '2EBB06834B7FA47A47FE',
    hotel => [
        ClubSpain::XML::Olympia::HotelAvailability::Hotel->new({
            Codigo            => 'CS000150',
            Nombre            => 'PLAYABONITA Gran Confort',
            CodigoPais        => '00034',
            CodigoProvincia   => '029',
            NombreProvincia   => 'MALAGA',
            Poblacion         => 'BENALMADENA',
            Categoria         => '4*',
            FechaEntrada      => '01/08/2007',
            FechaSalida       => '05/08/2007',
            room              => [
                ClubSpain::XML::Olympia::HotelAvailability::Room->new({
                    Habitacion  => '1',
                    Adultos     => '2',
                    ninos       => [
                        ClubSpain::XML::Olympia::HotelAvailability::Child->new({
                            age => 8
                        })
                    ],
                    numhab      => 2,
                    date        => [
                        ClubSpain::XML::Olympia::HotelAvailability::Date->new({
                            Servicio        => "HAB. DBL. MEDIA PENSION",
                            CodigoServicio  => "B0002",
                            CodigoConcepto  => "2000",
                            regimen         => "MP",
                            disponible      => "OK",
                            precio          => "990.39",
                            option          => [
                                ClubSpain::XML::Olympia::HotelAvailability::Option->new({
                                    Observaciones => 'SUPL. CORTA ESTANCIA 2-4 NOCHES'
                                })
                            ],
                        }),
                        ClubSpain::XML::Olympia::HotelAvailability::Date->new({
                            Servicio        => "HAB. COMUNICADA MEDIA PENSION",
                            CodigoServicio  => "A0022",
                            CodigoConcepto  => "2002",
                            regimen         => "MP",
                            disponible      => "OK",
                            precio          => "1361.78",
                            option          => [
                                ClubSpain::XML::Olympia::HotelAvailability::Option->new({
                                    Observaciones => 'SUPL. CORTA ESTANCIA 2-4 NOCHES'
                                })
                            ],
                        }),
                    ]
                })
          ]
        }),
        ClubSpain::XML::Olympia::HotelAvailability::Hotel->new({
            Codigo            => "CS009015",
            Nombre            => "TORREQUEBRADA",
            CodigoPais        => "00034",
            CodigoProvincia   => "029",
            NombreProvincia   => "MALAGA",
            Poblacion         => "BENALMADENA",
            Categoria         => "5*",
            FechaEntrada      => "01/08/2007",
            FechaSalida       => "05/08/2007",
            room              => [
                ClubSpain::XML::Olympia::HotelAvailability::Room->new({
                    Habitacion  => '1',
                    Adultos     => '2',
                    ninos       => [
                        ClubSpain::XML::Olympia::HotelAvailability::Child->new({
                            age => 8
                        })
                    ],
                    numhab      => 1,
                    date        => [
                        ClubSpain::XML::Olympia::HotelAvailability::Date->new({
                            Servicio        => "DOBLE M.P.",
                            CodigoServicio  => "B0018",
                            CodigoConcepto  => "2000",
                            regimen         => "MP",
                            disponible      => "OK",
                            precio          => "610.08",
                            option          => [
                                ClubSpain::XML::Olympia::HotelAvailability::Option->new({
                                    Observaciones => 'DTO. VENTA ANTICIPADA 30 DIAS ANTES'
                                })
                            ]
                        })
                    ]
                })
            ]
        })
    ]
}),



my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::HotelAvailability->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<'';
<?xml version="1.0" encoding="utf-8"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Disponibilidad>
      <CodigoPeticion>2EBB06834B7FA47A47FE</CodigoPeticion>
      <Hoteles>
        <Hotel>
          <Codigo>CS000150</Codigo>
          <Nombre>PLAYABONITA Gran Confort</Nombre>
          <CodigoPais>00034</CodigoPais>
          <CodigoProvincia>029</CodigoProvincia>
          <NombreProvincia>MALAGA</NombreProvincia>
          <Poblacion>BENALMADENA</Poblacion>
          <Categoria>4*</Categoria>
          <FechaEntrada>01/08/2007</FechaEntrada>
          <FechaSalida>05/08/2007</FechaSalida>
          <HabitacionesList>
            <Habitacion Ord="1">
              <Adultos>2</Adultos>
              <ninos num="1">
                <edad>8</edad>
              </ninos>
              <numhab>2</numhab>
              <DatosHabitacion>
                <Servicio>HAB. DBL. MEDIA PENSION</Servicio>
                <CodigoServicio>B0002</CodigoServicio>
                <CodigoConcepto>2000</CodigoConcepto>
                <regimen>MP</regimen>
                <disponible>OK</disponible>
                <precio>990.39</precio>
                <ObservacionesList>
                  <Observaciones>SUPL. CORTA ESTANCIA 2-4 NOCHES</Observaciones>
                </ObservacionesList>
              </DatosHabitacion>
              <DatosHabitacion>
                <Servicio>HAB. COMUNICADA MEDIA PENSION</Servicio>
                <CodigoServicio>A0022</CodigoServicio>
                <CodigoConcepto>2002</CodigoConcepto>
                <regimen>MP</regimen>
                <disponible>OK</disponible>
                <precio>1361.78</precio>
                <ObservacionesList>
                  <Observaciones>SUPL. CORTA ESTANCIA 2-4 NOCHES</Observaciones>
                </ObservacionesList>
              </DatosHabitacion>
            </Habitacion>
          </HabitacionesList>
        </Hotel>
        <Hotel>
          <Codigo>CS009015</Codigo>
          <Nombre>TORREQUEBRADA</Nombre>
          <CodigoPais>00034</CodigoPais>
          <CodigoProvincia>029</CodigoProvincia>
          <NombreProvincia>MALAGA</NombreProvincia>
          <Poblacion>BENALMADENA</Poblacion>
          <Categoria>5*</Categoria>
          <FechaEntrada>01/08/2007</FechaEntrada>
          <FechaSalida>05/08/2007</FechaSalida>
          <HabitacionesList>
            <Habitacion Ord="1">
              <Adultos>2</Adultos>
              <ninos num="1">
                <edad>8</edad>
              </ninos>
              <numhab>1</numhab>
              <DatosHabitacion>
                <Servicio>DOBLE M.P.</Servicio>
                <CodigoServicio>B0018</CodigoServicio>
                <CodigoConcepto>2000</CodigoConcepto>
                <regimen>MP</regimen>
                <disponible>OK</disponible>
                <precio>610.08</precio>
                <ObservacionesList>
                  <Observaciones>DTO. VENTA ANTICIPADA 30 DIAS ANTES</Observaciones>
                </ObservacionesList>
              </DatosHabitacion>
            </Habitacion>
          </HabitacionesList>
        </Hotel>
      </Hoteles>
    </Disponibilidad>
  </Respuesta>
</string>

}
