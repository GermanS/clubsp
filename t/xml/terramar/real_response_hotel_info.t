use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::HotelInfo');
use_ok('ClubSpain::XML::Terramar::Response::HotelInfo');

my $xml = read_file('t/var/terramar/response_hotel_info.xml');
my $result = ClubSpain::XML::Terramar::Response::HotelInfo->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @images = map new ClubSpain::XML::Terramar::HotelInfo::Image({ name => $_}), 
        qw( http://www.orbisbooking.com/dominios/tmt/fotos/22798_1.jpg
            http://www.orbisbooking.com/dominios/tmt/fotos/22798_2.jpg
            http://www.orbisbooking.com/dominios/tmt/fotos/22798_3.jpg
            http://www.orbisbooking.com/dominios/tmt/fotos/22798_4.jpg
            http://www.orbisbooking.com/dominios/tmt/fotos/22798_5.jpg
            http://www.orbisbooking.com/dominios/tmt/fotos/22798_6.jpg );
            
    my @caracteristicas = map new ClubSpain::XML::Terramar::HotelInfo::Caracteristica($_),
        (
        { categoria=>"", subcategoria=>"", nombre=>"Satellite TV", id_caracteristica=>"1", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Outdoor pool", id_caracteristica=>"2", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Disabled facilities only", id_caracteristica=>"3", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Restaurant", id_caracteristica=>"8", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Safe", id_caracteristica=>"16", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Organized activities", id_caracteristica=>"18", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Minibar", id_caracteristica=>"20", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"TV room", id_caracteristica=>"27", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Outside car park", id_caracteristica=>"29", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Heating", id_caracteristica=>"32", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Air conditioning", id_caracteristica=>"33", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Bar", id_caracteristica=>"34", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Conference room", id_caracteristica=>"45", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Telephone", id_caracteristica=>"61", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Balcony", id_caracteristica=>"65", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Lift", id_caracteristica=>"82", id_subcategoria=>"1", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"In-room music", id_caracteristica=>"88", id_subcategoria=>"2", valor=>"Si" },
        { categoria=>"", subcategoria=>"", nombre=>"Games room", id_caracteristica=>"133", id_subcategoria=>"1", valor=>"Si" },
        );
    
    my @expect = ({
      nif => "",
      nombre_comercial => "PALAS PINEDA",
      descripcion => "the hotel complex lies on 20,000 m2; of grounds with 3 buildings and comprises a total of 452 guest rooms the impressive reception hall is fitted with a 16 m high transparent dome, large windows and a grand staircase guests are offered a 24-hour reception desk, a currency exchange facility, a cloakroom and lift access, as well as diverse shops, a games room and a hairdressing salon for drinks and dining, guests can make use of the hotels cafe-bar, pub/nightclub and the dining halls fidias, olimpo and neptuno there is also the restaurant palas, open daily and offering a la carte meals in an exclusive atmosphere for conferences and other events, there are 4 banquet/meeting rooms for younger guests, there are organised childrens activities and a playground in addition, room and laundry services, as well as internet access and parking facilities, are offeredthis beach hotel is centrally situated just 100 m from the beautiful sandy beach the tourist resort of la pineda on the costa dorada lies about 100 m from the hotel, and shopping areas with boutiques, bars and restaurants are located nearby public transport departs from stops located directly in front of the hotelall rooms come with a fully-equipped bathroom with a hairdryer, as well as a direct dial telephone, a tv, a minibar, air conditioning, heating and a hire safe partial seaviews are available from the suitesthe expansive grounds include 2 outdoor pools, one of which is roofed, and a sun terrace with sun loungers and parasols, as well as a poolside snack bar an indoor pool is available during bad weather the hotel additionally offers a hot tub, sauna, turkish bath and massage service (for a fee) sports enthusiasts are offered an aerobic programme or may train in the gym in addition, table tennis and billiards facilities (for a fee) are available, along with a varied seasonal entertainment programmeguests may choose their breakfast, lunch and dinner from an ample buffet special dietary needs, as well as individual-specific meals may be provided guests may book an all-inclusive stay",
      direccion => "MONTANYALS,, 5",
      poblacion => "LA PINEDA",
      provincia => "",
      codigo_postal => "",
      telefono =>977370808,
      fax => 977372266,
      email => 'reservas@palaspineda.com',
      url => "www.palaspineda.com",
      categoria =>4,
      longitud =>'1.176700',
      latitud =>'41.068298',
      linea_bono_1 =>"",
      linea_bono_2 =>"",
      linea_bono_3 =>"",
      articulos_asociados =>17,
      imagen  => \@images,
      caracteristica => \@caracteristicas,      
    });
    
    my @objects;
    push @objects, new ClubSpain::XML::Terramar::HotelInfo($_)
        foreach (@expect);
      
    return \@objects;    
}
