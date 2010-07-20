use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::HotelContract');
use_ok('ClubSpain::XML::Terramar::Response::HotelContract');

my $xml = read_file('t/var/terramar/response_hotel_contract_details.xml');
my $result = ClubSpain::XML::Terramar::Response::HotelContract->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
        id_articulo => "9144",
        prestatario => "64503",
        nombre_articulo => "Suite Privilege",
        ocupacion => [
            new ClubSpain::XML::Terramar::HotelContract::Ocupacion({
                min_adultos => 4,
                max_adultos => 7,
                max_ninos   => 7,
                min_pax     => 4,
                max_pax     => 7,
            })
        ],
        rango => [
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-03-13", fecha_hasta => "2010-03-31",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"34.16", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"37.38", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"31.97", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"43.98", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-03-31", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-06-18", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },

                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-04-01", fecha_hasta => "2010-04-04",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"56.51", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"59.73", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"54.33", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"67.32", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-01", fecha_hasta=>"2010-04-04", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"2", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay", },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay", },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-06-18", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child", },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child", },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child", },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-04-05", fecha_hasta => "2010-05-28",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"34.16", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"37.38", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"31.97", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"43.98", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-06-18", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-05-29", fecha_hasta => "2010-06-04",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"46.12", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"49.34", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"43.94", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"56.94", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-06-18", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-06-05", fecha_hasta => "2010-06-18",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"56.52", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"59.74", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"54.34", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"67.34", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-06-18", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-06-19", fecha_hasta => "2010-07-02",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"70.35", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"73.58", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"68.17", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"81.69", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-06-19", fecha_hasta=>"2010-09-24", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-07-03", fecha_hasta => "2010-07-09",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"83.91", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"87.16", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"81.75", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"94.84", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-06-19", fecha_hasta=>"2010-09-24", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-07-10", fecha_hasta => "2010-07-30",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"87.69", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"90.94", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"85.48", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"95.63", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-06-19", fecha_hasta=>"2010-09-24", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-07-31", fecha_hasta => "2010-08-27",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"102.14", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"105.40", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"99.99", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"111.35", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-06-19", fecha_hasta=>"2010-09-24", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-08-28", fecha_hasta => "2010-09-10",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"61.24", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"64.50", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"59.03", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"72.23", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-06-19", fecha_hasta=>"2010-09-24", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-09-11", fecha_hasta => "2010-09-24",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"47.78", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"51.03", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"45.57", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"58.76", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax", },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay", },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay", },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax", },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax", },
                    { id_suplemento=>"60352", fecha_desde=>"2010-06-19", fecha_hasta=>"2010-09-24", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child", },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child", },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child", },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-09-25", fecha_hasta => "2010-10-01",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"38.25", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"41.52", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"36.05", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"48.09", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-09-25", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            }),
            new ClubSpain::XML::Terramar::HotelContract::Rango({
                fecha_desde => "2010-10-02", fecha_hasta => "2010-12-19",
                precio => [
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".BB", importe =>"36.16", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => ".HB", importe =>"39.42", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "AO", importe =>"33.96", importe_por=>"pax"
                    }),
                    new ClubSpain::XML::Terramar::HotelContract::Precio({
                        con_suplemento_de_regimen => "FB", importe =>"45.99", importe_por=>"pax"
                    })
                ],
                suplemento => [
                    map new ClubSpain::XML::Terramar::HotelContract::Suplemento($_),
                    { id_suplemento=>"60345", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"5th pax" },
                    { id_suplemento=>"60348", fecha_desde=>"2010-04-05", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"25.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"2", dias_maximo=>"3", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60349", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"50.00", id_clase=>"5", nombre_clase=>"SHORT STAY", dias_minimo=>"1", dias_maximo=>"1", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"Short Stay" },
                    { id_suplemento=>"60350", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"6th pax" },
                    { id_suplemento=>"60351", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-30.00", id_clase=>"2", nombre_clase=>"EXTRA PAX", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"7th pax" },
                    { id_suplemento=>"60352", fecha_desde=>"2010-09-25", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-100.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"1st Child" },
                    { id_suplemento=>"60353", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"2nd Child" },
                    { id_suplemento=>"60354", fecha_desde=>"2010-03-13", fecha_hasta=>"2010-12-19", pvp=>"0.00", porcentaje=>"-50.00", id_clase=>"3", nombre_clase=>"CHILDREN", edad_desde=>"2", edad_hasta=>"12", referencia_pb=>"1", obligatorio=>"0", importe_por=>"pax", rango_fechas=>"noche", suplemento=>"3rd child" },
                ]
            })
        ]
    });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::HotelContract($_)
        foreach (@expect);

    return \@objects;
}
