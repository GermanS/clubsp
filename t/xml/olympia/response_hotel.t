use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Hotel');
use_ok('ClubSpain::XML::Olympia::Response::Hotel');

my @expect = map new ClubSpain::XML::Olympia::Hotel($_),
{ Codigo => "CS000150", Nombre => "PLAYABONITA Gran Confort", Direccion => "CRTA. CADIZ, KM. 217", Telefono => "950627160", Email => "reservas\@playasenator.com", Pais => "00034",NombrePais => "Espana",Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: En 1n lnnea de playa Alojamiento: Dispone de 336 habitaciones con ventilador techo,bano completo,TV con antena parabnlica,caja de seguridad,minibar,telnfono y terraza con vista al mar. Instalaciones y Servicios: Piscinas,animacinn y deportes,miniclub,bar salnn,bar de copas,bar piscina,tienda,gimnasio,garaje y servicio ninera. Restauracinn: Buffet con cocina en vivo. Observaciones. - Admite animales ( consultar). - Posibilidad de "Todo Incluido". ', Categoria => "4*" },
{ Codigo => "CS000160", Nombre => "SAN FERMIN", Direccion => "AVDA. SAN FERMIN, 11", Telefono => "952577171", Email => "reservas\@hotelalay.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 300m de la playa, en el centro de Benalmndena Costa. Alojamiento: 316 habitaciones renovadas con vistas al mar n a la piscina/montana,bano completo,aire acondicionado,TV satnlite,telnfono,terraza y caja fuerte de alquiler. Instalaciones y Servicios: Pista de tenis,squash,restaurante,bar americano,jardnn,piscina para adultos y ninos y zona recreativa para ninos. Restauracinn: Tipo buffet. Observaciones: - Posibilidades para realizar actividades deportivas y recreativas en los alrededores. - Rampas para minusvnlidos. ', Categoria => "3*" },
{ Codigo => "CS002011", Nombre => "COMPLEJO LOS PINTORES", Direccion => "URB. TORREALMADENA - BENALMADENA COSTA", Telefono => "902383099", Email => "summahoteles\@summahoteles.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A unos 350 m de la playa de Santa Ana y a escasos metros del puerto deportivo. Alojamiento: Las habitaciones de los tres hoteles que componen el complejo estnn equipadas con bano completo,TV vna satnlite,caja fuerte,climatizacinn y telnfono directo. Instalaciones y ervicios: Piscina,solarium,bar-terraza-cafeterna y salnn social. Restauracinn: Buffet Observaciones: - Este complejo hotelero estn compuesto por los hoteles "Goya", "El Greco" y Velnzquez por lo que puede variar en algo las caracteristicas indicadas. ', Categoria => "3*" },
{ Codigo => "CS009015", Nombre => "TORREQUEBRADA", Direccion => "AVDA. DEL SOL S/N", Telefono => "952446000", Email => "reservas\@torrequebrada.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: 1n lnnea de playa y a pocos metros del campo de golf del mismo nombre. Alojamiento: 350 habitaciones y suites todas insonorizadas, con terrazas vistas al mar,aire acondicionado,TV vna satnlite e interactiva,hilo musical,telnfono directo,bano completo con secador,caja fuerte y minibar. Instalaciones y Servicios: Piscinas exteriores, piscina interior climatizada,pequeno gimnasio,sauna,sala de masajes,salnn de belleza,pista de tenis,amplio jardnn,salas de conferencias,sala de juegos,sala de fiesta,restaurante y programa de animacinn. Restauracinn: Desayuno buffet,almuerzo buffet n menn segnn temporada y cena buffet. Observaciones: - En el hotel estn ubicado el casino Torrequebrada y la sala de fiesta Fortuna - Estn catalogado como uno de los mayores de Espana - En el entorno se pueden practicar todo tipo de deportes - Adaptado para minusvnlidos - No admiten animales ', Categoria => "5*" },
{ Codigo => "CS009030", Nombre => "APARTAHOTEL FLATOTEL INTERNATIONAL", Direccion => "C/ RONDA DEL GOLF OESTE S/N", Telefono => "952445800", Email => "info\@flatotelcostadelsol.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 12 km de Mnlaga capital y a 200 m del Casino Torrequebrada. Alojamiento: Los apartamentos de 1, 2 n 3 dormitorios tienen aire acondicionado(frio/calor),TV vna satnlite,cocina completamente equipada incluida lavadora,caja fuerte,insonorizacinn y vista al mar. Instalaciones y Servicios: Piscina adultos y ninos,solarium,jardnn,restaurante,bar,gimnasio,supermercado,servicio mndico,beach club y acesso directo a la playa. Observaciones: - Apartamentos turnsticos con servicio de hotel. - Cambio de toallas diario. - Cambio de ropa de cama dos veces en semana. ', Categoria => "3*" },
{ Codigo => "CS009072", Nombre => "LOS PATOS", Direccion => "CRTA DE CADIZ KM 227 - BENALMADENA COSTA", Telefono => "952441990", Email => "Reservas.lospatos\@symbolhoteles.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situado en Benalmndena Costa, el Hotel Los Patos es el lugar perfecto para unas vacaciones relajadas, encontrnndose al mismo tiempo a 1 kilnmetro de distancia de Puerto Marina, lugar conocido por sus bares, restaurantes, tiendas, asn como por su vida nocturna. SITUACInN: Benalmndena Costa, a unos 250 metros de la playa, a 2 kilnmetros del centro de Benalmndena. CATEGORIA: 3*** SERVICIOS: restaurante buffet: desayuno, almuerzo y cena. Bar, bar piscina (en verano). INSTALACIONES: Recepcinn 24 horas, ascensores, aire acondicionado y calefaccinn en zonas comunes, sala de televisinn, sala de juegos, mini club, tienda, parking exterior. 1 piscina adultos y 1 piscina infantil, zona recreo ninos, hamacas y solarium. HABITACIONES: 277 habitaciones, 2 n 3 camas, aire acondicionado, calefaccinn, bano completo, terraza, telnfono directo, televisinn satnlite, caja fuerte (cargo extra). NnMERO DE PLANTAS: 10 ASCENSORES: 3 ANIMACInN: Diaria y nocturna, baile, cabaret, shows y noche flamenca una vez por semana. Mini Club para ninos en temporada alta. Hora Feliz todos los dnas. Billar y tenis de mesa. ', Categoria => "3*" },
{ Codigo => "CS009073", Nombre => "ALOHA PLAYA", Direccion => "CRTA DE CADIZ, KM. 221 - BENALMADENA COSTA", Telefono => "952441890", Email => "reservas\@alohaplayabenalmadena.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacion: Frente a la playa y a unos 8 km de Benalmadena pueblo Alojamiento: 240 apartamentos/estudios con bano completo,calefaccion/aire acondicionado,Tv satelite,minibar/nevera,caja de seguridad,kitchenette y balcon/terraza. Instalaciones y Servicios: pista de tenis,terraza solarium,sala maletero,lavandernia,programa de animacinon,jardines,bar y piscina. Restauracion: Buffet para el desayuno Observaciones: - No admiten animales ', Categoria => "3*" },
{ Codigo => "CS009120", Nombre => "BALI", Direccion => "AVDA. DE TELEFnNICA ,7 - BENALMnDENA COSTA", Telefono => "952441940", Email => "bali\@medplaya.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 250m de la playa y cerca del famoso puerto deportivo Puerto Marina, parque de atracciones Tnvoli y al lado del parque "La Paloma". Alojamiento: Todas las habitaciones y apartamentos con terraza, telnfono, bano completo, caja de seguridad, TV por satnlite y aire acondicionado/calefaccinn. Instalaciones y Servicios: Jardnnes con terraza,piscinas adultos y ninos,sala de juegos,parque infantil,aparcamiento privado,programa de animacinn,bar piscina,snack bar y barbacoa. Restauracinn: Buffet. Observaciones: - En los alrededores se encuentran multitud de facilidades e instalaciones para el ocio y el deporte. ', Categoria => "3*" },
{ Codigo => "CS900179", Nombre => "LA ROCA", Direccion => "CTRA. CADIZ KM 221,5", Telefono => "952441740", Email => "resaspmi\@palia.es", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacion: a 100 m de la bonita playa Santa Ana, en la region de Malaga. Alojamiento: 155 habitaciones equipadas con un cuarto de bano, telefono, TV satellite, caja fuerte en alquiler, aire acondicionado/calefacion, balcon. La mayoria de las habitaciones tienen vista mar. Servicios y Instalaciones: Restaurante climatizado, cafeteria-bar con terraza cubierta, salones, sala de juegos, 2 piscinas de agua dulce una de ellas cubierta y climatizada, zona acondicionada para los ninos, pinpong, petanca, dardos, badminton, waterpolo, tiro al arco y a la carabina. Restauracion: Las comidas son servidas en buffetes calientes y frios. El hotel propone tambien de show cooking. ', Categoria => "3*" },
{ Codigo => "CS900256", Nombre => "PALMASOL", Direccion => "AVDA. DEL MAR Nn 7 - BENALMADENA COSTA", Telefono => "952443547", Email => "palmasol\@h10.es", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: Frente al puerto deportivo Puerto Marina y a 250m de la playa. Alojamiento: Sus mns de 200 habitaciones ofrecen bano completo,telnfono,TV vna satnlite,ventilador y calefaccinn central. Instalaciones y Servicos: Bares y restaurantes,piscina exterior y climatizada,ping pong,billar,sala de cartas,salnn de TV,peluquerna,lavanderna,servicio mndico e internet. Restauracinn: Buffet con cocina en vivo. Observaciones: - No aceptan animales. ', Categoria => "3*" },
{ Codigo => "CS900313", Nombre => "VISTAMAR", Direccion => "CAMINO DE GILABERT S/N", Telefono => "952442827-HTL", Email => "reservas\@hotelvistamar.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 150 m de la playa y a 1 km del campo de golf Torrequebrada. Alojamiento: Habitaciones,estudios y apartamentos con pequena cocina con electrodomnsticos,bano completo,salnn con sofn cama,TV,telnfono,caja fuerte,aire acondicionado,calefaccinn y terraza. Instalaciones y Servicios: garaje privado,cuarto de lavanderna,secado y plancha "self service",servicio mndico,salnn de banquetes y congresos,piscina adultos y ninos,bar piscina en verano,mnsica en vivo,cafeterna,miniclub,salnn de juegos y animacinn para ninos segnn temporada. Restauracinn: Buffet para el desayuno y la cena, a la carta para el almuerzo. Observaciones: - Adaptado para minusvnlidos - No admite animales - Servicio de aseo y duchas para el dna de salida. ', Categoria => "4*" },
{ Codigo => "CS900314", Nombre => "VILLASOL", Direccion => "AVDA. ANTONIO MACHADO 43", Telefono => "952441996", Email => "villasol22\@yahoo.es", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: 1n linea de playa y junto al puerto deportivo. Alojamiento: 120 habitaciones climatizadas con telnfono directo,bano completo,caja fuerte,TV vna satnlite y terraza con vistas al mar. Instalaciones y Servicios: Piano Bar con animacinn en directo, snack bar,restaurante,cafeterna,cambio de divisas,parking privado,piscina,salnn TV,jardnn,programa de animacinn para todas las edades y organizacinn de eventos. Restauracinn: Restaurante Internacional con cocina gastronnmica. Observaciones: Multitud de actividades de ocio y deportes en los alrededores. ', Categoria => "3*" },
{ Codigo => "CS900397", Nombre => "LAS ARENAS", Direccion => "AVDA. ANTONIO MACHADO, 22", Telefono => "952443644", Email => "reservaslasarenas\@symbolhoteles.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 120 m de la playa y a 1km del centro urbano. Alojamiento: Cuenta con 170 habitaciones decoradas con sumo gusto y con aire acondicionado,calefaccinn,bano completo,vista piscina/mar,caja fuerte,telnfono y TV. Instalaciones y Servicios: Parking exterior,jardines,piscinas,sala TV,restaurante,tumbonas y mnsica en vivo. Restauracinn: Desayuno y cena tipo buffet. Observaciones: - No admiten animales. ', Categoria => "4*" },
{ Codigo => "CS900430", Nombre => "BENALMADENA PALACE", Direccion => "CAMINO DE GILABERT S/N", Telefono => "952964958", Email => "reservas\@benalmadenapalace.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 300m de la playa y a 2 km del centro urbano. Alojamiento: 183 habitaciones con TV, telnfono, Internet, bano completo,caja fuerte, aire acondicionado, calefaccinn y amplia terraza. Instalaciones y Servicios: Piscina exterior y climatizada, sauna, gimnasio, jacuzzi,jardines,programa de animacinn,zona de ninos,minigolf,lavanderna auto-servicio,peluquerna,minimarket,garaje y servicio mndico. Restauracinn: Desayuno y cena tipo buffet, almuerzo buffet n menn segnn temporada. Observaciones: - No admiten animales. - Inaugurado en primavera de 2004. ', Categoria => "4*" },
{ Codigo => "CS900471", Nombre => "RIU PUERTO MARINA", Direccion => "URB. MARINA DE BENALMADENA S/N", Telefono => "952050534", Email => "hotel.puertomarinabenalmadena\@riu.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: A 90 m de la playa y a 200m del centro comercial Alojamiento: 272 habitaciones con bano completo,telnfono,aire acondicionado/calefaccinn central,ventilador de techo,minibar,TV vna satnlite,caja fuerte y balcnn/terraza. Instalaciones y Servicios: Bar salnn,acesso a internet,piscina 8 en invierno climatizada),solarium,bar piscina y programa de animacinn. Restauracinn: Desayuno y Cena tipo buffet Observaciones: - Inauguracinn en verano de 2005 - Posibilidad de realizar multitud de actividades y deportes en los alrededores. ', Categoria => "4*" },
{ Codigo => "CS900531", Nombre => "APTOS. JARDINES DEL GAMONAL", Direccion => "C/ZODIACO, 7 BLQ 4 - LOCAL 6", Telefono => "952447587", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Alojamiento: Estudio con salon grande con dos camas mas sofa, TV, cocina equipada, curto de bano y terraza. Apartamentos de 1 y 2 dormitorios condos camas en dormitorio aparte y sofa-cama doble en el salon. Servicios y Instalaciones: Jardines, piscina, en alquiler caja fuerte y garaje, limpieza y cambio de toallas 2 veces por semana, cambio de sabanas 1 vez por semana. ', Categoria => "2*", Email=> "" },
{ Codigo => "CS900550", Nombre => "HOLIDAY PALACE", Direccion => "CTRA NAC - 340 KM. 215,6", Telefono => "952579757 - rva", Email => "reservas\@holidayworld.es", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Alojamiento: habitacinn Junior Suite con capacidad mnxima de 4 personas equipadas con TV por satnlite con mando a distancia, limpieza y cambio diario de toallas, cambio de snbanas 2 veces por semana, minibar compuesto de agua y refrescos con reposiciones diarias, room service. Instalaciones y Servicios: piscinas, hamacas y toallas de piscina, health club (de 10.00h a 14.00 y de 15.00 a 19.00. El acceso a jacuzzi y gimnasio son gratuitos, el resto de servicios (sauna, masajes...) es previo pago), Beach Club (tenis, padel, balonvolea, baloncesto, fntbol 7 gratuitos segnn disponibilidad), entretenimiento nocturno e infantil, recepcinn 24 horas, clnnica 24 horas, ciber cafn, supermercado, cajas de seguridad. Restauracinn: restaurante "The Gallery" abierto para el desayuno (08.00 a 10.30h) y cena (18.30 a 21.30). Las comidas sernn en el restaurante "Le Mirage" (de abril a octubre, de 12.00 a 15.30h). Bar Atlantis y Le Mirage en el Beach Club. Bar La Tahona y Snack Chambao en el hotel. Observaciones: - Servicio de autobns de 10.00 de la manana a 18.00 de la tarde para el desplazamiento al Beach Club. ', Categoria => "4*" },
{ Codigo => "CS900561", Nombre => "APTOS. LA HACIENDA", Direccion => "C/DE LA HACIENDA, 40 URB. LA HACIENDA", Telefono => "952569053", Email => "", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacion: En una urbanizacion privada en 1 km de Benalmadena Alojamiento: 6 apartamentos con 2 dormitorios, salon con cama para 1 persona, bano completo cocina electrica completamente equipada y gran terraza. 4 aticos con el mismo equipamiento mas terraza superior con ducha, 5 hamacas, mesa y vistas panoramicas. 2 apartamentos mas con jardin privado. Todos apartamentos tienen aire acondicionado, telefono, internet, caja fuerte, TV satelite con DVD. Servicios: Limpieza y cambio de toallas 3 veces por semana, cambio de sabanas 2 veces por semana, plancha y tabla para planchar. ', Categoria => "Apto.3LL" },
{ Codigo => "CS900565", Nombre => "SUNSET BEACH CLUB", Direccion => "AVDA. DEL SOL, Nn 5", Telefono => "952579400", Email => "reservas\@sunsetbeachclub.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacinn: En primera lnnea de playa, a 2.5 Km del puerto de Benalmndena y 8 Km de Fuengirola centro. Alojamiento: Dispone de 553 apartamentos desde 37.3m cuadrados recientemente reformados con salnn con sofn cama, comedor con mesa y 4 sillas, dormitorio, cocina totalmente equipada, bano y terraza con vistas al mar, montana o patio interior, climatizador, caja fuerte (con cargo), lnnea telefnnica y televisinn satnlite. Instalaciones y servicios: Dos piscinas (una climatizada en invierno), piscina para ninos y zona de juegos infantiles, centro mndico, peluquerna, salnn de belleza, servicio de lavanderna y tintorerna, supermercado, garaje cubierto y tiendas. Restauracinn: restaurante Oasis (desayuno buffet, almuerzos y cena a la carta), Cnctel-Bar y Salnn Panorama (abierto desde las 12:00 hasta la tarde con la popular "Happy Hour"), bar piscina y cafn Playa Pierino (frente al mar, decorado en estilo tropical) ', Categoria => "4*" },
{ Codigo => "CS900577", Nombre => "BETANIA", Direccion => "CONTRERAS S/N AVDA ROCIO JURADO", Telefono => "952577786", Email => "recepcion\@hotelbetania.es", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacion: Junto a la playa, a 100 m del parque La Paloma y a 600 m de Puerto Marino, entorno tranquilo con zonas verdes. Alojamento: Dispone de 53 habitaciones con vista al mar, regimen media pencion, piscina y solarium con vista al mar, salones de TV - antena parabolica. Restauracion: Restaurante y cafeteria. ', Categoria => "2*" },
{ Codigo => "CS900592", Nombre => "HOLIDAY VILLAGE", Direccion => "CN-340, KM 215,6", Telefono => "952579700", Email => "reservas\@holidayworld.es", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion => 'Situacion: En primera linea de playa. Alojamiento: Habitaciones estan equipadas con TV via satelite, telefono, bano, algunas estan adaptadas para minusvalidos. Servicios y Instalaciones: Jardin botanico, club juvenil, sala de cunas, club infantil, mini golf, multitienda, piano bar, pub Irlandes, piscina, salon de espectaculos. Restauracion: Restaurante Italiano, restaurante Mexicano, restaurante Buffet, Snak bar, bar junto a la piscina ', Categoria => "4*" },
{ Codigo => "CS900597", Nombre => "VISTA DE REY", Direccion => "C/GUADALMEDINA S/N URB. TORREMUELLE", Telefono => "952198073", Email => "comercial\@vistaderey.com", Pais => "00034", NombrePais => "Espana", Provincia => "029", NombreProvincia => "MALAGA", Poblacion => "11", NombrePoblacion => "BENALMADENA", Descripcion =>'', Categoria => "3*" };



my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Hotel->parse($response);

is_deeply($result, \@expect, 'returned hotels');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Establecimientos>
      <Establecimiento>
        <Codigo>CS000150</Codigo>
        <Nombre>PLAYABONITA Gran Confort</Nombre>
        <Direccion>CRTA. CADIZ, KM. 217</Direccion>
        <Telefono>950627160</Telefono>
        <Email>reservas\@playasenator.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: En 1n lnnea de playa Alojamiento: Dispone de 336 habitaciones con ventilador techo,bano completo,TV con antena parabnlica,caja de seguridad,minibar,telnfono y terraza con vista al mar. Instalaciones y Servicios: Piscinas,animacinn y deportes,miniclub,bar salnn,bar de copas,bar piscina,tienda,gimnasio,garaje y servicio ninera. Restauracinn: Buffet con cocina en vivo. Observaciones. - Admite animales ( consultar). - Posibilidad de "Todo Incluido". </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS000160</Codigo>
        <Nombre>SAN FERMIN</Nombre>
        <Direccion>AVDA. SAN FERMIN, 11</Direccion>
        <Telefono>952577171</Telefono>
        <Email>reservas\@hotelalay.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 300m de la playa, en el centro de Benalmndena Costa. Alojamiento: 316 habitaciones renovadas con vistas al mar n a la piscina/montana,bano completo,aire acondicionado,TV satnlite,telnfono,terraza y caja fuerte de alquiler. Instalaciones y Servicios: Pista de tenis,squash,restaurante,bar americano,jardnn,piscina para adultos y ninos y zona recreativa para ninos. Restauracinn: Tipo buffet. Observaciones: - Posibilidades para realizar actividades deportivas y recreativas en los alrededores. - Rampas para minusvnlidos. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS002011</Codigo>
        <Nombre>COMPLEJO LOS PINTORES</Nombre>
        <Direccion>URB. TORREALMADENA - BENALMADENA COSTA</Direccion>
        <Telefono>902383099</Telefono>
        <Email>summahoteles\@summahoteles.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A unos 350 m de la playa de Santa Ana y a escasos metros del puerto deportivo. Alojamiento: Las habitaciones de los tres hoteles que componen el complejo estnn equipadas con bano completo,TV vna satnlite,caja fuerte,climatizacinn y telnfono directo. Instalaciones y ervicios: Piscina,solarium,bar-terraza-cafeterna y salnn social. Restauracinn: Buffet Observaciones: - Este complejo hotelero estn compuesto por los hoteles "Goya", "El Greco" y Velnzquez por lo que puede variar en algo las caracteristicas indicadas. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009015</Codigo>
        <Nombre>TORREQUEBRADA</Nombre>
        <Direccion>AVDA. DEL SOL S/N</Direccion>
        <Telefono>952446000</Telefono>
        <Email>reservas\@torrequebrada.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: 1n lnnea de playa y a pocos metros del campo de golf del mismo nombre. Alojamiento: 350 habitaciones y suites todas insonorizadas, con terrazas vistas al mar,aire acondicionado,TV vna satnlite e interactiva,hilo musical,telnfono directo,bano completo con secador,caja fuerte y minibar. Instalaciones y Servicios: Piscinas exteriores, piscina interior climatizada,pequeno gimnasio,sauna,sala de masajes,salnn de belleza,pista de tenis,amplio jardnn,salas de conferencias,sala de juegos,sala de fiesta,restaurante y programa de animacinn. Restauracinn: Desayuno buffet,almuerzo buffet n menn segnn temporada y cena buffet. Observaciones: - En el hotel estn ubicado el casino Torrequebrada y la sala de fiesta Fortuna - Estn catalogado como uno de los mayores de Espana - En el entorno se pueden practicar todo tipo de deportes - Adaptado para minusvnlidos - No admiten animales </Descripcion>
        <Categoria>5*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009030</Codigo>
        <Nombre>APARTAHOTEL FLATOTEL INTERNATIONAL</Nombre>
        <Direccion>C/ RONDA DEL GOLF OESTE S/N</Direccion>
        <Telefono>952445800</Telefono>
        <Email>info\@flatotelcostadelsol.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 12 km de Mnlaga capital y a 200 m del Casino Torrequebrada. Alojamiento: Los apartamentos de 1, 2 n 3 dormitorios tienen aire acondicionado(frio/calor),TV vna satnlite,cocina completamente equipada incluida lavadora,caja fuerte,insonorizacinn y vista al mar. Instalaciones y Servicios: Piscina adultos y ninos,solarium,jardnn,restaurante,bar,gimnasio,supermercado,servicio mndico,beach club y acesso directo a la playa. Observaciones: - Apartamentos turnsticos con servicio de hotel. - Cambio de toallas diario. - Cambio de ropa de cama dos veces en semana. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009072</Codigo>
        <Nombre>LOS PATOS</Nombre>
        <Direccion>CRTA DE CADIZ KM 227 - BENALMADENA COSTA</Direccion>
        <Telefono>952441990</Telefono>
        <Email>Reservas.lospatos\@symbolhoteles.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situado en Benalmndena Costa, el Hotel Los Patos es el lugar perfecto para unas vacaciones relajadas, encontrnndose al mismo tiempo a 1 kilnmetro de distancia de Puerto Marina, lugar conocido por sus bares, restaurantes, tiendas, asn como por su vida nocturna. SITUACInN: Benalmndena Costa, a unos 250 metros de la playa, a 2 kilnmetros del centro de Benalmndena. CATEGORIA: 3*** SERVICIOS: restaurante buffet: desayuno, almuerzo y cena. Bar, bar piscina (en verano). INSTALACIONES: Recepcinn 24 horas, ascensores, aire acondicionado y calefaccinn en zonas comunes, sala de televisinn, sala de juegos, mini club, tienda, parking exterior. 1 piscina adultos y 1 piscina infantil, zona recreo ninos, hamacas y solarium. HABITACIONES: 277 habitaciones, 2 n 3 camas, aire acondicionado, calefaccinn, bano completo, terraza, telnfono directo, televisinn satnlite, caja fuerte (cargo extra). NnMERO DE PLANTAS: 10 ASCENSORES: 3 ANIMACInN: Diaria y nocturna, baile, cabaret, shows y noche flamenca una vez por semana. Mini Club para ninos en temporada alta. Hora Feliz todos los dnas. Billar y tenis de mesa. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009073</Codigo>
        <Nombre>ALOHA PLAYA</Nombre>
        <Direccion>CRTA DE CADIZ, KM. 221 - BENALMADENA COSTA</Direccion>
        <Telefono>952441890</Telefono>
        <Email>reservas\@alohaplayabenalmadena.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacion: Frente a la playa y a unos 8 km de Benalmadena pueblo Alojamiento: 240 apartamentos/estudios con bano completo,calefaccion/aire acondicionado,Tv satelite,minibar/nevera,caja de seguridad,kitchenette y balcon/terraza. Instalaciones y Servicios: pista de tenis,terraza solarium,sala maletero,lavandernia,programa de animacinon,jardines,bar y piscina. Restauracion: Buffet para el desayuno Observaciones: - No admiten animales </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009120</Codigo>
        <Nombre>BALI</Nombre>
        <Direccion>AVDA. DE TELEFnNICA ,7 - BENALMnDENA COSTA</Direccion>
        <Telefono>952441940</Telefono>
        <Email>bali\@medplaya.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 250m de la playa y cerca del famoso puerto deportivo Puerto Marina, parque de atracciones Tnvoli y al lado del parque "La Paloma". Alojamiento: Todas las habitaciones y apartamentos con terraza, telnfono, bano completo, caja de seguridad, TV por satnlite y aire acondicionado/calefaccinn. Instalaciones y Servicios: Jardnnes con terraza,piscinas adultos y ninos,sala de juegos,parque infantil,aparcamiento privado,programa de animacinn,bar piscina,snack bar y barbacoa. Restauracinn: Buffet. Observaciones: - En los alrededores se encuentran multitud de facilidades e instalaciones para el ocio y el deporte. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900179</Codigo>
        <Nombre>LA ROCA</Nombre>
        <Direccion>CTRA. CADIZ KM 221,5</Direccion>
        <Telefono>952441740</Telefono>
        <Email>resaspmi\@palia.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacion: a 100 m de la bonita playa Santa Ana, en la region de Malaga. Alojamiento: 155 habitaciones equipadas con un cuarto de bano, telefono, TV satellite, caja fuerte en alquiler, aire acondicionado/calefacion, balcon. La mayoria de las habitaciones tienen vista mar. Servicios y Instalaciones: Restaurante climatizado, cafeteria-bar con terraza cubierta, salones, sala de juegos, 2 piscinas de agua dulce una de ellas cubierta y climatizada, zona acondicionada para los ninos, pinpong, petanca, dardos, badminton, waterpolo, tiro al arco y a la carabina. Restauracion: Las comidas son servidas en buffetes calientes y frios. El hotel propone tambien de show cooking. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900256</Codigo>
        <Nombre>PALMASOL</Nombre>
        <Direccion>AVDA. DEL MAR Nn 7 - BENALMADENA COSTA</Direccion>
        <Telefono>952443547</Telefono>
        <Email>palmasol\@h10.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: Frente al puerto deportivo Puerto Marina y a 250m de la playa. Alojamiento: Sus mns de 200 habitaciones ofrecen bano completo,telnfono,TV vna satnlite,ventilador y calefaccinn central. Instalaciones y Servicos: Bares y restaurantes,piscina exterior y climatizada,ping pong,billar,sala de cartas,salnn de TV,peluquerna,lavanderna,servicio mndico e internet. Restauracinn: Buffet con cocina en vivo. Observaciones: - No aceptan animales. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900313</Codigo>
        <Nombre>VISTAMAR</Nombre>
        <Direccion>CAMINO DE GILABERT S/N</Direccion>
        <Telefono>952442827-HTL</Telefono>
        <Email>reservas\@hotelvistamar.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 150 m de la playa y a 1 km del campo de golf Torrequebrada. Alojamiento: Habitaciones,estudios y apartamentos con pequena cocina con electrodomnsticos,bano completo,salnn con sofn cama,TV,telnfono,caja fuerte,aire acondicionado,calefaccinn y terraza. Instalaciones y Servicios: garaje privado,cuarto de lavanderna,secado y plancha "self service",servicio mndico,salnn de banquetes y congresos,piscina adultos y ninos,bar piscina en verano,mnsica en vivo,cafeterna,miniclub,salnn de juegos y animacinn para ninos segnn temporada. Restauracinn: Buffet para el desayuno y la cena, a la carta para el almuerzo. Observaciones: - Adaptado para minusvnlidos - No admite animales - Servicio de aseo y duchas para el dna de salida. </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900314</Codigo>
        <Nombre>VILLASOL</Nombre>
        <Direccion>AVDA. ANTONIO MACHADO 43</Direccion>
        <Telefono>952441996</Telefono>
        <Email>villasol22\@yahoo.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: 1n linea de playa y junto al puerto deportivo. Alojamiento: 120 habitaciones climatizadas con telnfono directo,bano completo,caja fuerte,TV vna satnlite y terraza con vistas al mar. Instalaciones y Servicios: Piano Bar con animacinn en directo, snack bar,restaurante,cafeterna,cambio de divisas,parking privado,piscina,salnn TV,jardnn,programa de animacinn para todas las edades y organizacinn de eventos. Restauracinn: Restaurante Internacional con cocina gastronnmica. Observaciones: Multitud de actividades de ocio y deportes en los alrededores. </Descripcion>
        <Categoria>3*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900397</Codigo>
        <Nombre>LAS ARENAS</Nombre>
        <Direccion>AVDA. ANTONIO MACHADO, 22</Direccion>
        <Telefono>952443644</Telefono>
        <Email>reservaslasarenas\@symbolhoteles.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 120 m de la playa y a 1km del centro urbano. Alojamiento: Cuenta con 170 habitaciones decoradas con sumo gusto y con aire acondicionado,calefaccinn,bano completo,vista piscina/mar,caja fuerte,telnfono y TV. Instalaciones y Servicios: Parking exterior,jardines,piscinas,sala TV,restaurante,tumbonas y mnsica en vivo. Restauracinn: Desayuno y cena tipo buffet. Observaciones: - No admiten animales. </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900430</Codigo>
        <Nombre>BENALMADENA PALACE</Nombre>
        <Direccion>CAMINO DE GILABERT S/N</Direccion>
        <Telefono>952964958</Telefono>
        <Email>reservas\@benalmadenapalace.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 300m de la playa y a 2 km del centro urbano. Alojamiento: 183 habitaciones con TV, telnfono, Internet, bano completo,caja fuerte, aire acondicionado, calefaccinn y amplia terraza. Instalaciones y Servicios: Piscina exterior y climatizada, sauna, gimnasio, jacuzzi,jardines,programa de animacinn,zona de ninos,minigolf,lavanderna auto-servicio,peluquerna,minimarket,garaje y servicio mndico. Restauracinn: Desayuno y cena tipo buffet, almuerzo buffet n menn segnn temporada. Observaciones: - No admiten animales. - Inaugurado en primavera de 2004. </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900471</Codigo>
        <Nombre>RIU PUERTO MARINA</Nombre>
        <Direccion>URB. MARINA DE BENALMADENA S/N</Direccion>
        <Telefono>952050534</Telefono>
        <Email>hotel.puertomarinabenalmadena\@riu.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: A 90 m de la playa y a 200m del centro comercial Alojamiento: 272 habitaciones con bano completo,telnfono,aire acondicionado/calefaccinn central,ventilador de techo,minibar,TV vna satnlite,caja fuerte y balcnn/terraza. Instalaciones y Servicios: Bar salnn,acesso a internet,piscina 8 en invierno climatizada),solarium,bar piscina y programa de animacinn. Restauracinn: Desayuno y Cena tipo buffet Observaciones: - Inauguracinn en verano de 2005 - Posibilidad de realizar multitud de actividades y deportes en los alrededores. </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900531</Codigo>
        <Nombre>APTOS. JARDINES DEL GAMONAL</Nombre>
        <Direccion>C/ZODIACO, 7 BLQ 4 - LOCAL 6</Direccion>
        <Telefono>952447587</Telefono>
        <Email/>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Alojamiento: Estudio con salon grande con dos camas mas sofa, TV, cocina equipada, curto de bano y terraza. Apartamentos de 1 y 2 dormitorios condos camas en dormitorio aparte y sofa-cama doble en el salon. Servicios y Instalaciones: Jardines, piscina, en alquiler caja fuerte y garaje, limpieza y cambio de toallas 2 veces por semana, cambio de sabanas 1 vez por semana. </Descripcion>
        <Categoria>2*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900550</Codigo>
        <Nombre>HOLIDAY PALACE</Nombre>
        <Direccion>CTRA NAC - 340 KM. 215,6</Direccion>
        <Telefono>952579757 - rva</Telefono>
        <Email>reservas\@holidayworld.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Alojamiento: habitacinn Junior Suite con capacidad mnxima de 4 personas equipadas con TV por satnlite con mando a distancia, limpieza y cambio diario de toallas, cambio de snbanas 2 veces por semana, minibar compuesto de agua y refrescos con reposiciones diarias, room service. Instalaciones y Servicios: piscinas, hamacas y toallas de piscina, health club (de 10.00h a 14.00 y de 15.00 a 19.00. El acceso a jacuzzi y gimnasio son gratuitos, el resto de servicios (sauna, masajes...) es previo pago), Beach Club (tenis, padel, balonvolea, baloncesto, fntbol 7 gratuitos segnn disponibilidad), entretenimiento nocturno e infantil, recepcinn 24 horas, clnnica 24 horas, ciber cafn, supermercado, cajas de seguridad. Restauracinn: restaurante "The Gallery" abierto para el desayuno (08.00 a 10.30h) y cena (18.30 a 21.30). Las comidas sernn en el restaurante "Le Mirage" (de abril a octubre, de 12.00 a 15.30h). Bar Atlantis y Le Mirage en el Beach Club. Bar La Tahona y Snack Chambao en el hotel. Observaciones: - Servicio de autobns de 10.00 de la manana a 18.00 de la tarde para el desplazamiento al Beach Club. </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900561</Codigo>
        <Nombre>APTOS. LA HACIENDA</Nombre>
        <Direccion>C/DE LA HACIENDA, 40 URB. LA HACIENDA</Direccion>
        <Telefono>952569053</Telefono>
        <Email/>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacion: En una urbanizacion privada en 1 km de Benalmadena Alojamiento: 6 apartamentos con 2 dormitorios, salon con cama para 1 persona, bano completo cocina electrica completamente equipada y gran terraza. 4 aticos con el mismo equipamiento mas terraza superior con ducha, 5 hamacas, mesa y vistas panoramicas. 2 apartamentos mas con jardin privado. Todos apartamentos tienen aire acondicionado, telefono, internet, caja fuerte, TV satelite con DVD. Servicios: Limpieza y cambio de toallas 3 veces por semana, cambio de sabanas 2 veces por semana, plancha y tabla para planchar. </Descripcion>
        <Categoria>Apto.3LL</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900565</Codigo>
        <Nombre>SUNSET BEACH CLUB</Nombre>
        <Direccion>AVDA. DEL SOL, Nn 5</Direccion>
        <Telefono>952579400</Telefono>
        <Email>reservas\@sunsetbeachclub.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacinn: En primera lnnea de playa, a 2.5 Km del puerto de Benalmndena y 8 Km de Fuengirola centro. Alojamiento: Dispone de 553 apartamentos desde 37.3m cuadrados recientemente reformados con salnn con sofn cama, comedor con mesa y 4 sillas, dormitorio, cocina totalmente equipada, bano y terraza con vistas al mar, montana o patio interior, climatizador, caja fuerte (con cargo), lnnea telefnnica y televisinn satnlite. Instalaciones y servicios: Dos piscinas (una climatizada en invierno), piscina para ninos y zona de juegos infantiles, centro mndico, peluquerna, salnn de belleza, servicio de lavanderna y tintorerna, supermercado, garaje cubierto y tiendas. Restauracinn: restaurante Oasis (desayuno buffet, almuerzos y cena a la carta), Cnctel-Bar y Salnn Panorama (abierto desde las 12:00 hasta la tarde con la popular "Happy Hour"), bar piscina y cafn Playa Pierino (frente al mar, decorado en estilo tropical) </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900577</Codigo>
        <Nombre>BETANIA</Nombre>
        <Direccion>CONTRERAS S/N AVDA ROCIO JURADO</Direccion>
        <Telefono>952577786</Telefono>
        <Email>recepcion\@hotelbetania.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacion: Junto a la playa, a 100 m del parque La Paloma y a 600 m de Puerto Marino, entorno tranquilo con zonas verdes. Alojamento: Dispone de 53 habitaciones con vista al mar, regimen media pencion, piscina y solarium con vista al mar, salones de TV - antena parabolica. Restauracion: Restaurante y cafeteria. </Descripcion>
        <Categoria>2*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900592</Codigo>
        <Nombre>HOLIDAY VILLAGE</Nombre>
        <Direccion>CN-340, KM 215,6</Direccion>
        <Telefono>952579700</Telefono>
        <Email>reservas\@holidayworld.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion>Situacion: En primera linea de playa. Alojamiento: Habitaciones estan equipadas con TV via satelite, telefono, bano, algunas estan adaptadas para minusvalidos. Servicios y Instalaciones: Jardin botanico, club juvenil, sala de cunas, club infantil, mini golf, multitienda, piano bar, pub Irlandes, piscina, salon de espectaculos. Restauracion: Restaurante Italiano, restaurante Mexicano, restaurante Buffet, Snak bar, bar junto a la piscina </Descripcion>
        <Categoria>4*</Categoria>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900597</Codigo>
        <Nombre>VISTA DE REY</Nombre>
        <Direccion>C/GUADALMEDINA S/N URB. TORREMUELLE</Direccion>
        <Telefono>952198073</Telefono>
        <Email>comercial\@vistaderey.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Descripcion/>
        <Categoria>3*</Categoria>
      </Establecimiento>
    </Establecimientos>
  </Respuesta>
</string>



}
