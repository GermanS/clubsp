use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::HotelPB');
use_ok('ClubSpain::XML::Olympia::Response::HotelPB');

my @expect = map new ClubSpain::XML::Olympia::HotelPB($_),
{ Codigo => 'CS000150', Nombre => 'PLAYABONITA Gran Confort',  Direccion => 'CRTA. CADIZ, KM. 217', Telefono => '950627160', Email => "reservas\@playasenator.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.59228515625', Latitud => '36.58376164626612', Descripcion => 'Location : In front of the beach. Accommodation: 336 rooms with ceiling fan, full bathroom with TV and parabolic antenna, safe boc, minibar, telephone and terrace overlooking the sea. Facilities and Services: Swimming pools, entertainement activities and sports, miniclub, bar, swimming pool bar, shops, gymnasium, garage and baby-sitter. Catering: Buffet with live cooking Additional Information: - Pets are allowed (consult us). - All inclusive optional', },
{ Codigo => 'CS000160', Nombre => 'SAN FERMIN', Direccion => 'AVDA. SAN FERMIN, 11', Telefono => '952577171', Email => "reservas\@hotelalay.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.523926377296440', Latitud => '36.594542703032600', Descripcion => 'Location : 300m away from the beach, in the Benalmndena Costa downtown. Accommodation: 316 renovated rooms overlooking the sea or the swimming pool/mountain, full bathroom, air conditioning, satellite TV, telephone, terrace and safe box for rent. Facilities and Services: Tennis court, squash, restaurant, American bar, garden, swimming pool for adults and children and amusement area for children. Catering: Buffet. Additional Information: - Probability for practicing sport and amusement activities nearby. - Ramps for disabled people. ', },
{ Codigo => 'CS002011', Nombre => 'COMPLEJO LOS PINTORES', Direccion => 'URB. TORREALMADENA - BENALMADENA COSTA', Telefono => '902383099', Email => "summahoteles\@summahoteles.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.522730112075800', Latitud => '36.59713975208260', Descripcion => 'Location : Over 350m away from Santa Ana beach and a few meters from the sports port. Accommodation: The rooms of the three hotels, being part of the resort, are provided with full private bathrooms, satellite TV, safe box, air-conditioning and direct-dial telephone. Facilities and Services: Swimming pool, solarium, bar n terrace n coffee shop, and social events room. Catering: Buffet. Additional Information: This hotel resort is formed by the following hotels: Goya, El Greco and Velnsquez, therefore, the before mentioned details might vary a little.', },
{ Codigo => 'CS009013', Nombre => 'SIROCO', Direccion => 'CARRIL DEL SIROCO, S/N - BENALMADENA COSTA', Telefono => '952443045-RVAS', Email => "siroco\@besthotels.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.521796703338623', Latitud => '36.5971311384658', Descripcion => 'Location : 200m away from the beach and 200m away from the urban downtown. Accommodation: 398 rooms provided with air-conditioning, safe box, full private bathrooms, satellite TV and terraces, many of them overlooking the sea or the mountains. Facilities and Services: Garden, sauna, Jacuzzi, steam room, swimming pool, gymnasium, table-tennis, swimming pools for adults and for children, restaurant, swimming pool bar, parking lot, entertainment program and play area for children. Catering: Buffet breakfast, lunch and dinner. Additional Information: Use of some services or installations requires additional payment. Pets are not allowed.', },
{ Codigo => 'CS009015', Nombre => 'TORREQUEBRADA', Direccion => 'AVDA. DEL SOL S/N', Telefono => '952446000', Email => "reservas\@torrequebrada.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '5*', Longitud => '-4.5418596267700100', Latitud => '36.5801776774524', Descripcion => 'Location : In front of the beach first line and a few meters away from a golf course having the same name. Accommodation: 350 soundless rooms and suites, with terraces overlooking the sea, air-conditioning, satellite and interactive TV, and room music, direct-dial telephone, full private bathrooms provided with hairdryer, safe box, and mini bar. Facilities and Services: Outdoor swimming pools, indoor heated swimming pools, a small gymnasium, sauna, massages room, beauty parlor, tennis court, a big garden, conference rooms, play room, social events room, restaurant, and entertainment program. Catering: Buffet breakfast, buffet- or menu-like lunch according to the season and buffet dinner. Additional Information: The Torrequebrada casino and the Fortuna party room are located in the hotel. It is considered as one of the biggest one of Spain. Any type of sports can be practiced nearby. It is customized for disabled people. Dogs are not allowed.', },
{ Codigo => 'CS009027', Nombre => 'TRITON', Direccion => 'AVDA. ANTONIO MACHADO, 29 - BENALMADENA COSTA', Telefono => '952443240', Email => "triton\@besthotels.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.519511461257930', Latitud => '36.59663154704140', Descripcion => 'Location : In front of the beach and 200 m from urban center. Accommodation: 373 rooms provided with air conditioning/heating system, telephone, minibar, safe box with extra payment, full bathroom with hairdryer, satellite TV and terrace / balcony with sea lateral view. Facilities and Services: garden, sauna, Jacuzzi, hairdressing, 2 swimming pools for adults and children, playroom with tables for games, tennis court, gymnasium, ping pong, shop, parking lot, entertainment program and swimming pool bar. Catering: buffet breakfast and dinner. Additional Information: - Pets are not allowed- The use of some services are extra paid. ', },
{ Codigo => 'CS009030', Nombre => 'APARTAHOTEL FLATOTEL INTERNATIONAL', Direccion => 'C/ RONDA DEL GOLF OESTE S/N', Telefono => '952445800', Email => "info\@flatotelcostadelsol.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.550979137420654', Latitud => '36.584502542141806', Descripcion => 'Location : 12 km from Mnlaga capital and 200 m away from the Casino Torrequebrada. Accommodation: The 1, 2 or 3 bedrooms apartments are provided with air conditioning (cold/heat), satellite TV, full equipped kitchen including washing machine, safe box, soundless system and overlooking the sea. Facilities and Services: Adults and children swimming pool, solarium, garden, restaurant, bar, gymnasium, supermarket, health service, beach club and direct access to the beach. Additional Information: - Tourist apartments with hotel service. - Towels change daily. - Bed linen change twice a week.', },
{ Codigo => 'CS009072', Nombre => 'LOS PATOS', Direccion => 'CRTA DE CADIZ KM 227 - BENALMADENA COSTA', Telefono => '952441990', Email => "Reservas.lospatos\@symbolhoteles.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => ' -4.63897705078125', Latitud => '36.57142382346277', Descripcion => 'Modern hotel situated in the Benalmndena Costa residential zone, 200 meters away from the beach, wholly renovated in 2007. 274 rooms, all of them provided with terrace, full bathroom, hairdryer, air conditioning, satellite television, mini bar and safe box. Large reception room, coffee shop, playroom, boutique, miniclub, day and night entertainment. Big garden with solarium, open-air swimming pool, children swimming pool and heated swimming pool. Recreational zones for adults and children park. Open air and interior parking lot. Excellent service of Catering, show cooking, buffet breakfast, lunch and dinner.', },
{ Codigo => 'CS009073', Nombre => 'ALOHA PLAYA', Direccion => 'CRTA DE CADIZ, KM. 221 - BENALMADENA COSTA', Telefono => '952441890', Email => "reservas\@alohaplayabenalmadena.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => ' -4.63897705078125', Latitud => '36.57142382346277', Descripcion => 'Location : In front of the beach and some 8 km away from Benalmadena town Accommodation: 240 apartments/study rooms provided with full bathroom, heating/air conditioning, satellite TV, minibar/frigobar, safe box, kitchenette and balcony/terrace. Facilities and Services: tennis court, terrace solarium, luggage room, laundry, entertainment program, gardens, bar and swimming pool. Catering: Buffet breakfast. Additional Information: - Pets are not allowed', },
{ Codigo => 'CS009120', Nombre => 'BALI', Direccion => 'AVDA. DE TELEFnNICA ,7 - BENALMnDENA COSTA', Telefono => '952441940', Email => "reservasbali\@medplaya.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.523014426231380', Latitud => '36.59546007860230', Descripcion => 'Location : 250m from the beach and near the Puerto Marina famous sport harbor, Tnvoli Funfair Park and right by the La Paloma park. Accommodation: All rooms and apartments are provided with terrace, telephone, full bathroom, safe box, satellite TV and air conditioning/heating. Facilities and Services: Gardens with terrace, swimming pools for adults and children, play room, children park, private parking lot, entertainment program, swimming pool bar, snack bar and barbecue. Catering: Buffet. Additional Information: - Nearby there are countless facilities and installations for leisure and sport.', },
{ Codigo => 'CS500006', Nombre => 'BEST BENALMADENA', Direccion => 'CRTA. CADIZ KM 220', Telefono => '952445088', Email => "bestbenalmadena\@besthotels.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.558296203613281', Latitud => '36.58245213849012', Descripcion => 'Location : 5m away from the beach and 100m from urban centre. Accommodation: 250 rooms provided with air conditioning / heating, telephone, minibar, satellite TV terrace/balcony overlooking the sea. Facilities and Services: Swimming pool with bar, gymnasium, open air Jacuzzi, restaurant, sauna, hairdressing, steam room, reading room and garden. Catering: All buffet services. Additional Information: - Inaugurated in Summer 2003. ', },
{ Codigo => 'CS900179', Nombre => 'LA ROCA', Direccion => 'CTRA. CADIZ KM 221,5', Telefono => '952441740', Email => "resaspmi\@palia.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.523191452026367', Latitud => '36.592996491357354', Descripcion => 'Location : 100m away from the beautiful Santa Ana beach, in Malaga region. Accommodation: 155 rooms provided with private bathrooms, telephone, satellite TV, safe box renting, air-conditioning /heating, balcony. Most of the rooms overlook the sea. Facilities and Services: Air-conditioning restaurant, coffee shop n bar with indoor terrace, rooms, play room, 2 fresh water swimming pools, one of them it is an indoor heated one, customized area for children, tale-tennis, petanque, darts, badminton, water polo, arching shooting and carabine shooting. Catering: Hot and cold buffet meals. The hotel suggests the show cooking.', },
{ Codigo => 'CS900256', Nombre => 'PALMASOL', Direccion => 'AVDA. DEL MAR Nn 7 - BENALMADENA COSTA', Telefono => '952443547', Email => "reservas.hpl\@h10.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.5151448249816800', Latitud => '36.598509304934900', Descripcion => 'Location : In front of the Sports Harbour nPuerto Marina and 250m away from the beach. Accommodation: More than 200 rooms provided with full private bathroom, telephone, satellite TV, fans, central heating. Facilities and Services: Bars and restaurants, outdoor and indoor swimming pool, table-tennis, billiards, carts room, TV room, hairdressing, laundry, health service and Internet. Catering: Buffet service and show cooking. Additional Information: Dogs are not allowed.', },
{ Codigo => 'CS900313', Nombre => 'VISTAMAR', Direccion => 'CAMINO DE GILABERT S/N', Telefono => '952442827-HTL', Email => "reservas\@hotelvistamar.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.526023864746094', Latitud => '36.59844039719614', Descripcion => 'Location : 150m away from the beach and 1km from the Torrequebrada golf course. Accommodation: Rooms, study-rooms and apartments provided with a kitchenette, household and wares full private bathroom, room with a sofa, TV, telephone, safe box, air-conditioning, heating and terrace. Facilities and Services: Private garage, laundry room, drying and self service ironing, health service, banquet room and conference room, swimming pool for adults and for children, swimming pool bar in summer, live music, coffee shop mini club, play room and entertainment for children according to the season. Catering: Buffet breakfast and dinner, and n la carte lunch. Additional Information: It is customized for disabled people. Dogs are not allowed, Cleaning and shower service for departure day.', },
{ Codigo => 'CS900314', Nombre => 'VILLASOL', Direccion => 'AVDA. ANTONIO MACHADO 43', Telefono => '952441996', Email => "villasol22\@yahoo.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-6.37831449508667', Latitud => '36.584674842489100', Descripcion => 'Location : In front of the beach and next to the sport harbour. Accommodation: 120 rooms provided with air- conditioning, directndial telephone, full private bathroom, safe box, satellite TV and terrace overlooking the sea. Facilities and Services: piano bar with live entertainment, snack bar, restaurant, coffee shop, money exchange, private parking lot, swimming pool, TV room, garden, entertainment program for all ages and event organization. Catering: International restaurant with gastronomic cooking. Additional Information: Many leisure and sports activities nearby.', },
{ Codigo => 'CS900397', Nombre => 'LAS ARENAS', Direccion => 'AVDA. ANTONIO MACHADO, 22', Telefono => '952443644', Email => "reservaslasarenas\@symbolhoteles.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.518443942070000', Latitud => '36.59794942777580', Descripcion => 'Location : 120m away from the beach and 1km away from urban downtown. Accommodation: 170 rooms very well decorated and provided with air-conditioning, heating, full private bathroom, with sea/swimming pool views, safe box, telephone and TV. Facilities and Services: outdoor parking lot, gardens, swimming pools, TV room, restaurant, sun loungers, live music. Catering: Buffet breakfast and dinner. Additional Information: Dogs are not allowed.', },
{ Codigo => 'CS900430', Nombre => 'BENALMADENA PALACE', Direccion => 'CAMINO DE GILABERT S/N', Telefono => '952964958', Email => "reservas\@benalmadenapalace.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.5365166664123500', Latitud => '36.58462315242520', Descripcion => 'Location : 300m away from the beach and 2 km away from the city center. Accommodation: 183 bedrooms with TV, telephone, internet, fully equipped bathroom, safe box, air conditioning, heating, large terrace. Facilities and Services: Outdoor air-conditioned swimming pool, sauna, gymnasium, Jacuzzi, gardens, entertainment activities, childrenn area, mini golf, laundry, self-service, hairdresserns, mini shopping center, garage, and medical service. Catering: Buffet ntype breakfast and dinner, buffet lunch or seasonal menu. Additional Information: No pets allowed n Inaugurated in the spring of 2004. ', },
{ Codigo => 'CS900471', Nombre => 'RIU PUERTO MARINA', Direccion => 'URB. MARINA DE BENALMADENA S/N',  Telefono => '952050534', Email => "hotel.puertomarinabenalmadena\@riu.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.5114970207214355', Latitud => '36.59885384270578', Descripcion => 'Location : Only 90 meters away from the beach and 200 meters away from the commercial center. Accommodation: 272 bedrooms with fully equipped bathroom, telephone, air conditioning, heating, ceiling fan, minibar, satellite TV, safe box, and terrace / balcony. Facilities and Services: Bar, hall, Internet, swimming pool (air-conditioned in winter), solarium, and bar in the swimming pool, entertainment activities. Catering: Buffet Breakfast and Dinner Additional Information: Inaugurated in summer 2005 n It offers the possibility of doing a wide variety of activities and sports in the neighbouring areas. ', },
{ Codigo => 'CS900531', Nombre => 'APTOS. JARDINES DEL GAMONAL', Direccion => 'C/ZODIACO, 7 BLQ 4 - LOCAL 6', Telefono => '952447587', Email => "", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '2*', Longitud => '-4.529510736465450', Latitud => '36.59832842198930', Descripcion => 'Accommodation: Study with spacious room equipped with 2 beds and a sofa, TV, fully equipped kitchen, bathroom and terrace. 1- and 2- bedroom Apartments with 2 beds in the bedroom and double sofa bed in the room. Facilities and Services: Gardens, swimming pools, safe box, garage for renting, cleaning and towel change twice a week, and bedclothes change once a week. ', },
{ Codigo => 'CS900550', Nombre => 'HOLIDAY PALACE', Direccion => 'CTRA NAC - 340 KM. 215,6', Telefono => '952579757 - rva', Email => "reservas\@holidayworld.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.585075378417969', Latitud => '36.57633506453712', Descripcion => 'Accommodation: Junior Suite bedroom for 4 people equipped with satellite TV with remote control, daily change of towels, change of bedclothes twice a week, mini bar offering water and soft drinks with daily supply, room service. Facilities and Services: Swimming pools, hammocks, swimming pool towels, health club (10:00 n 14:00hs and 15:00- 19:00hs). Free access to Jacuzzi and gymnasium, all the other services must be paid in advance, Beach club (tennis, paddle, volleyball, basketball, football n free depending on availability), evening and childrenns entertainment, 24-hour reception, 24-hour medical service, cyber cafn, shopping-center, safe box. Catering: Restaurant The Gallery open for breakfast (8:00-10:30hs) and Dinner (18:30 n 21:30hs). The meals will be in Le Mirage restaurant (April n October, from 12:00 until 15:30hs). Bar Atlantis and Le Mirage in the Beach Club. Bar La Tahona and Snack Chambao in the hotel. Additional Information: Bus service to Beach Club from 10:00 to 18:00hs ', },
{ Codigo => 'CS900561', Nombre => 'APTOS. LA HACIENDA', Direccion => 'AVDA. DE LA HACIENDA, 40 URB. LA HACIENDA', Telefono => '952569053', Email => "", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => 'Apto.3LL', Longitud => '-4.565548896789551', Latitud => '36.596562637625595', Descripcion => 'Location : In a private housing estate, 1 km away from Benalmadena. Accommodation: 6 Apartments with 2 bedrooms, room with a single bed, fully equipped bathroom, electric stove and spacious terrace. 4 attics with the same equipment plus terrace with shower, 5 hammocks, table and panoramic views. 2 more Apartments with private garden. All the Apartments are equipped with air-conditioning, telephone, Internet, safe box, satellite TV, DVD service. Towel cleaning and change 3 times a week, bedclothes change twice a week, iron and ironing board. ', },
{ Codigo => 'CS900565', Nombre => 'SUNSET BEACH CLUB', Direccion => 'AVDA. DEL SOL, Nn 5', Telefono => '952579400', Email => "reservas\@sunsetbeachclub.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '4*', Longitud => '-4.571020603179930', Latitud => '36.5784804033995', Descripcion => 'Location : Beachfront, 2.5 km away from the Port of Benalmndena and 8 km away from center of Fuengirola. Accommodation: Offers 553 Apartments from 37.3m2 recently restored with a room with sofa bed. Dining-room with table and 4 chairs, bedroom, fully equipped kitchen, bathroom and terrace overlooking the sea and the mountains, or interior patio, air-conditioning, safe box (extra payment), telephone and satellite TV. Facilities and Services: 2 swimming pools (1 of them air-conditioned in winter), childrenns swimming pool and childrenns playground, medical center, hairdresserns, beauty parlor, laundry and dry-cleanerns service, shopping-center, indoor garage and shops. Catering: Restaurant Oasis (Buffet breakfast, n la carte lunch and dinner), cocktail bar, room with panoramic view (open from 12:00 until the afternoon with the popular Happy Hour), bar by swimming pool, and coffee shop Playa Pierino (beachfront, decorated in tropical style)', },
{ Codigo => 'CS900577', Nombre => 'BETANIA', Direccion => 'CONTRERAS S/N AVDA ROCIO JURADO', Telefono => '952577786', Email => "recepcion\@hotelbetania.es", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '2*', Longitud => '-4.530830383300781', Latitud => '36.59179051088516', Descripcion => 'Location : Next to the beach, 100 meters away from the park La Paloma and 600 meters from Port Merino, quiet surroundings with green spaces. Accommodation: It has 53 bedrooms overlooking the sea, half-boarding system, and solarium with view of the sea, TV rooms, and parabolic antenna. Catering: restaurant and coffee shop.', },
{ Codigo => 'CS900597', Nombre => 'VISTA DE REY', Direccion => 'C/GUADALMEDINA S/N URB. TORREMUELLE', Telefono => '952441717', Email => "reservasvistaderey\@aquaria-hotels.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.523513317108154', Latitud => '36.60092103702007', Descripcion => 'Surrounded by green spaces, only a few meters away from the hotel. The apart-hotel Vista de Rey has 61 bedrooms, most of them overlooking the sea. 24-hour guest reception and service. Bar Corona: 8:00 n 24:00hs n Room service until 23:00hs n Free transport to the beach of Torremuelle- self-service laundry n garage n swimming pool- 24-hour medical service- luggage equipment for late check-outs. All the bedrooms have a sofa-bed, built-in cupboard, air-conditioning, and heating, satellite TV, safe box, fully equipped bathroom, terrace, telephone, fully equipped kitchen with glass-ceramics of 2 hot-plates, fridge, coffee-pot, water boiler, toast-maker, microwave, kitchen utensils for 4 meals.', },
{ Codigo => 'CS900630', Nombre => 'PLAZOLETA, HOTEL 2** BENALMADENA', Direccion => 'AVDA. JUAN LUIS PERALTA, S/N', Telefono => '952448197', Email => "plazoleta\@fondahotel.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '2*', Longitud => '-4.568632', Latitud => '36.599548', Descripcion => '' },
{ Codigo => 'CS900635', Nombre => 'LA FONDA, 3*** BENALMADENA', Direccion => 'C/ SANTO DOMINGO, 7', Telefono => '952568273', Email => "lafonda\@fondahotel.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => '3*', Longitud => '-4.529521465301514', Latitud => '36.58986090292927', Descripcion => '' },
{ Codigo => 'CS900636', Nombre => 'DORAMAR, APTOS 3 LLAVES, BENALMADENA', Direccion => 'C/ CARRIL DEL SIROCO, 6', Telefono => '952562708', Email => "info\@apartamentosdoramar.com", Pais => '00034', NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => 'Apto.3LL', Longitud => '-4.520895481109619', Latitud => '36.59704500224411', Descripcion => '' },
{ Codigo => 'CS900637', Nombre => 'TAMARINDOS, APTOS. 2 LLAVES', Direccion => 'C/ TAMARINDOS, 2', Telefono => '952574081', Pais => '00034', Email => "", NombrePais => 'Espana', Provincia => '029', NombreProvincia => 'MALAGA', Poblacion => '11', NombrePoblacion => 'BENALMADENA', Categoria => 'Apto.2LL', Longitud => '-4.517848491668701', Latitud => '36.59726895622048', Descripcion => '' };


my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::HotelPB->parse($response);

is_deeply($result, \@expect, 'returned hotels');

sub response {
    return <<'';
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Establecimientos>
      <Establecimiento>
        <Codigo>CS000150</Codigo>
        <Nombre>PLAYABONITA Gran Confort</Nombre>
        <Direccion>CRTA. CADIZ, KM. 217</Direccion>
        <Telefono>950627160</Telefono>
        <Email>reservas@playasenator.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.59228515625</Longitud>
        <Latitud>36.58376164626612</Latitud>
        <Descripcion>Location : In front of the beach. Accommodation: 336 rooms with ceiling fan, full bathroom with TV and parabolic antenna, safe boc, minibar, telephone and terrace overlooking the sea. Facilities and Services: Swimming pools, entertainement activities and sports, miniclub, bar, swimming pool bar, shops, gymnasium, garage and baby-sitter. Catering: Buffet with live cooking Additional Information: - Pets are allowed (consult us). - All inclusive optional</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS000160</Codigo>
        <Nombre>SAN FERMIN</Nombre>
        <Direccion>AVDA. SAN FERMIN, 11</Direccion>
        <Telefono>952577171</Telefono>
        <Email>reservas@hotelalay.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.523926377296440</Longitud>
        <Latitud>36.594542703032600</Latitud>
        <Descripcion>Location : 300m away from the beach, in the Benalmndena Costa downtown. Accommodation: 316 renovated rooms overlooking the sea or the swimming pool/mountain, full bathroom, air conditioning, satellite TV, telephone, terrace and safe box for rent. Facilities and Services: Tennis court, squash, restaurant, American bar, garden, swimming pool for adults and children and amusement area for children. Catering: Buffet. Additional Information: - Probability for practicing sport and amusement activities nearby. - Ramps for disabled people. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS002011</Codigo>
        <Nombre>COMPLEJO LOS PINTORES</Nombre>
        <Direccion>URB. TORREALMADENA - BENALMADENA COSTA</Direccion>
        <Telefono>902383099</Telefono>
        <Email>summahoteles@summahoteles.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.522730112075800</Longitud>
        <Latitud>36.59713975208260</Latitud>
        <Descripcion>Location : Over 350m away from Santa Ana beach and a few meters from the sports port. Accommodation: The rooms of the three hotels, being part of the resort, are provided with full private bathrooms, satellite TV, safe box, air-conditioning and direct-dial telephone. Facilities and Services: Swimming pool, solarium, bar n terrace n coffee shop, and social events room. Catering: Buffet. Additional Information: This hotel resort is formed by the following hotels: Goya, El Greco and Velnsquez, therefore, the before mentioned details might vary a little.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009013</Codigo>
        <Nombre>SIROCO</Nombre>
        <Direccion>CARRIL DEL SIROCO, S/N - BENALMADENA COSTA</Direccion>
        <Telefono>952443045-RVAS</Telefono>
        <Email>siroco@besthotels.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.521796703338623</Longitud>
        <Latitud>36.5971311384658</Latitud>
        <Descripcion>Location : 200m away from the beach and 200m away from the urban downtown. Accommodation: 398 rooms provided with air-conditioning, safe box, full private bathrooms, satellite TV and terraces, many of them overlooking the sea or the mountains. Facilities and Services: Garden, sauna, Jacuzzi, steam room, swimming pool, gymnasium, table-tennis, swimming pools for adults and for children, restaurant, swimming pool bar, parking lot, entertainment program and play area for children. Catering: Buffet breakfast, lunch and dinner. Additional Information: Use of some services or installations requires additional payment. Pets are not allowed.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009015</Codigo>
        <Nombre>TORREQUEBRADA</Nombre>
        <Direccion>AVDA. DEL SOL S/N</Direccion>
        <Telefono>952446000</Telefono>
        <Email>reservas@torrequebrada.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>5*</Categoria>
        <Longitud>-4.5418596267700100</Longitud>
        <Latitud>36.5801776774524</Latitud>
        <Descripcion>Location : In front of the beach first line and a few meters away from a golf course having the same name. Accommodation: 350 soundless rooms and suites, with terraces overlooking the sea, air-conditioning, satellite and interactive TV, and room music, direct-dial telephone, full private bathrooms provided with hairdryer, safe box, and mini bar. Facilities and Services: Outdoor swimming pools, indoor heated swimming pools, a small gymnasium, sauna, massages room, beauty parlor, tennis court, a big garden, conference rooms, play room, social events room, restaurant, and entertainment program. Catering: Buffet breakfast, buffet- or menu-like lunch according to the season and buffet dinner. Additional Information: The Torrequebrada casino and the Fortuna party room are located in the hotel. It is considered as one of the biggest one of Spain. Any type of sports can be practiced nearby. It is customized for disabled people. Dogs are not allowed.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009027</Codigo>
        <Nombre>TRITON</Nombre>
        <Direccion>AVDA. ANTONIO MACHADO, 29 - BENALMADENA COSTA</Direccion>
        <Telefono>952443240</Telefono>
        <Email>triton@besthotels.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.519511461257930</Longitud>
        <Latitud>36.59663154704140</Latitud>
        <Descripcion>Location : In front of the beach and 200 m from urban center. Accommodation: 373 rooms provided with air conditioning/heating system, telephone, minibar, safe box with extra payment, full bathroom with hairdryer, satellite TV and terrace / balcony with sea lateral view. Facilities and Services: garden, sauna, Jacuzzi, hairdressing, 2 swimming pools for adults and children, playroom with tables for games, tennis court, gymnasium, ping pong, shop, parking lot, entertainment program and swimming pool bar. Catering: buffet breakfast and dinner. Additional Information: - Pets are not allowed- The use of some services are extra paid. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009030</Codigo>
        <Nombre>APARTAHOTEL FLATOTEL INTERNATIONAL</Nombre>
        <Direccion>C/ RONDA DEL GOLF OESTE S/N</Direccion>
        <Telefono>952445800</Telefono>
        <Email>info@flatotelcostadelsol.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.550979137420654</Longitud>
        <Latitud>36.584502542141806</Latitud>
        <Descripcion>Location : 12 km from Mnlaga capital and 200 m away from the Casino Torrequebrada. Accommodation: The 1, 2 or 3 bedrooms apartments are provided with air conditioning (cold/heat), satellite TV, full equipped kitchen including washing machine, safe box, soundless system and overlooking the sea. Facilities and Services: Adults and children swimming pool, solarium, garden, restaurant, bar, gymnasium, supermarket, health service, beach club and direct access to the beach. Additional Information: - Tourist apartments with hotel service. - Towels change daily. - Bed linen change twice a week.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009072</Codigo>
        <Nombre>LOS PATOS</Nombre>
        <Direccion>CRTA DE CADIZ KM 227 - BENALMADENA COSTA</Direccion>
        <Telefono>952441990</Telefono>
        <Email>Reservas.lospatos@symbolhoteles.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud> -4.63897705078125</Longitud>
        <Latitud>36.57142382346277</Latitud>
        <Descripcion>Modern hotel situated in the Benalmndena Costa residential zone, 200 meters away from the beach, wholly renovated in 2007. 274 rooms, all of them provided with terrace, full bathroom, hairdryer, air conditioning, satellite television, mini bar and safe box. Large reception room, coffee shop, playroom, boutique, miniclub, day and night entertainment. Big garden with solarium, open-air swimming pool, children swimming pool and heated swimming pool. Recreational zones for adults and children park. Open air and interior parking lot. Excellent service of Catering, show cooking, buffet breakfast, lunch and dinner.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009073</Codigo>
        <Nombre>ALOHA PLAYA</Nombre>
        <Direccion>CRTA DE CADIZ, KM. 221 - BENALMADENA COSTA</Direccion>
        <Telefono>952441890</Telefono>
        <Email>reservas@alohaplayabenalmadena.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud> -4.63897705078125</Longitud>
        <Latitud>36.57142382346277</Latitud>
        <Descripcion>Location : In front of the beach and some 8 km away from Benalmadena town Accommodation: 240 apartments/study rooms provided with full bathroom, heating/air conditioning, satellite TV, minibar/frigobar, safe box, kitchenette and balcony/terrace. Facilities and Services: tennis court, terrace solarium, luggage room, laundry, entertainment program, gardens, bar and swimming pool. Catering: Buffet breakfast. Additional Information: - Pets are not allowed</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS009120</Codigo>
        <Nombre>BALI</Nombre>
        <Direccion>AVDA. DE TELEFnNICA ,7 - BENALMnDENA COSTA</Direccion>
        <Telefono>952441940</Telefono>
        <Email>reservasbali@medplaya.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.523014426231380</Longitud>
        <Latitud>36.59546007860230</Latitud>
        <Descripcion>Location : 250m from the beach and near the Puerto Marina famous sport harbor, Tnvoli Funfair Park and right by the La Paloma park. Accommodation: All rooms and apartments are provided with terrace, telephone, full bathroom, safe box, satellite TV and air conditioning/heating. Facilities and Services: Gardens with terrace, swimming pools for adults and children, play room, children park, private parking lot, entertainment program, swimming pool bar, snack bar and barbecue. Catering: Buffet. Additional Information: - Nearby there are countless facilities and installations for leisure and sport.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS500006</Codigo>
        <Nombre>BEST BENALMADENA</Nombre>
        <Direccion>CRTA. CADIZ KM 220</Direccion>
        <Telefono>952445088</Telefono>
        <Email>bestbenalmadena@besthotels.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.558296203613281</Longitud>
        <Latitud>36.58245213849012</Latitud>
        <Descripcion>Location : 5m away from the beach and 100m from urban centre. Accommodation: 250 rooms provided with air conditioning / heating, telephone, minibar, satellite TV terrace/balcony overlooking the sea. Facilities and Services: Swimming pool with bar, gymnasium, open air Jacuzzi, restaurant, sauna, hairdressing, steam room, reading room and garden. Catering: All buffet services. Additional Information: - Inaugurated in Summer 2003. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900179</Codigo>
        <Nombre>LA ROCA</Nombre>
        <Direccion>CTRA. CADIZ KM 221,5</Direccion>
        <Telefono>952441740</Telefono>
        <Email>resaspmi@palia.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.523191452026367</Longitud>
        <Latitud>36.592996491357354</Latitud>
        <Descripcion>Location : 100m away from the beautiful Santa Ana beach, in Malaga region. Accommodation: 155 rooms provided with private bathrooms, telephone, satellite TV, safe box renting, air-conditioning /heating, balcony. Most of the rooms overlook the sea. Facilities and Services: Air-conditioning restaurant, coffee shop n bar with indoor terrace, rooms, play room, 2 fresh water swimming pools, one of them it is an indoor heated one, customized area for children, tale-tennis, petanque, darts, badminton, water polo, arching shooting and carabine shooting. Catering: Hot and cold buffet meals. The hotel suggests the show cooking.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900256</Codigo>
        <Nombre>PALMASOL</Nombre>
        <Direccion>AVDA. DEL MAR Nn 7 - BENALMADENA COSTA</Direccion>
        <Telefono>952443547</Telefono>
        <Email>reservas.hpl@h10.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.5151448249816800</Longitud>
        <Latitud>36.598509304934900</Latitud>
        <Descripcion>Location : In front of the Sports Harbour nPuerto Marina and 250m away from the beach. Accommodation: More than 200 rooms provided with full private bathroom, telephone, satellite TV, fans, central heating. Facilities and Services: Bars and restaurants, outdoor and indoor swimming pool, table-tennis, billiards, carts room, TV room, hairdressing, laundry, health service and Internet. Catering: Buffet service and show cooking. Additional Information: Dogs are not allowed.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900313</Codigo>
        <Nombre>VISTAMAR</Nombre>
        <Direccion>CAMINO DE GILABERT S/N</Direccion>
        <Telefono>952442827-HTL</Telefono>
        <Email>reservas@hotelvistamar.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.526023864746094</Longitud>
        <Latitud>36.59844039719614</Latitud>
        <Descripcion>Location : 150m away from the beach and 1km from the Torrequebrada golf course. Accommodation: Rooms, study-rooms and apartments provided with a kitchenette, household and wares full private bathroom, room with a sofa, TV, telephone, safe box, air-conditioning, heating and terrace. Facilities and Services: Private garage, laundry room, drying and self service ironing, health service, banquet room and conference room, swimming pool for adults and for children, swimming pool bar in summer, live music, coffee shop mini club, play room and entertainment for children according to the season. Catering: Buffet breakfast and dinner, and n la carte lunch. Additional Information: It is customized for disabled people. Dogs are not allowed, Cleaning and shower service for departure day.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900314</Codigo>
        <Nombre>VILLASOL</Nombre>
        <Direccion>AVDA. ANTONIO MACHADO 43</Direccion>
        <Telefono>952441996</Telefono>
        <Email>villasol22@yahoo.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-6.37831449508667</Longitud>
        <Latitud>36.584674842489100</Latitud>
        <Descripcion>Location : In front of the beach and next to the sport harbour. Accommodation: 120 rooms provided with air- conditioning, directndial telephone, full private bathroom, safe box, satellite TV and terrace overlooking the sea. Facilities and Services: piano bar with live entertainment, snack bar, restaurant, coffee shop, money exchange, private parking lot, swimming pool, TV room, garden, entertainment program for all ages and event organization. Catering: International restaurant with gastronomic cooking. Additional Information: Many leisure and sports activities nearby.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900397</Codigo>
        <Nombre>LAS ARENAS</Nombre>
        <Direccion>AVDA. ANTONIO MACHADO, 22</Direccion>
        <Telefono>952443644</Telefono>
        <Email>reservaslasarenas@symbolhoteles.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.518443942070000</Longitud>
        <Latitud>36.59794942777580</Latitud>
        <Descripcion>Location : 120m away from the beach and 1km away from urban downtown. Accommodation: 170 rooms very well decorated and provided with air-conditioning, heating, full private bathroom, with sea/swimming pool views, safe box, telephone and TV. Facilities and Services: outdoor parking lot, gardens, swimming pools, TV room, restaurant, sun loungers, live music. Catering: Buffet breakfast and dinner. Additional Information: Dogs are not allowed.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900430</Codigo>
        <Nombre>BENALMADENA PALACE</Nombre>
        <Direccion>CAMINO DE GILABERT S/N</Direccion>
        <Telefono>952964958</Telefono>
        <Email>reservas@benalmadenapalace.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.5365166664123500</Longitud>
        <Latitud>36.58462315242520</Latitud>
        <Descripcion>Location : 300m away from the beach and 2 km away from the city center. Accommodation: 183 bedrooms with TV, telephone, internet, fully equipped bathroom, safe box, air conditioning, heating, large terrace. Facilities and Services: Outdoor air-conditioned swimming pool, sauna, gymnasium, Jacuzzi, gardens, entertainment activities, childrenn area, mini golf, laundry, self-service, hairdresserns, mini shopping center, garage, and medical service. Catering: Buffet ntype breakfast and dinner, buffet lunch or seasonal menu. Additional Information: No pets allowed n Inaugurated in the spring of 2004. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900471</Codigo>
        <Nombre>RIU PUERTO MARINA</Nombre>
        <Direccion>URB. MARINA DE BENALMADENA S/N</Direccion>
        <Telefono>952050534</Telefono>
        <Email>hotel.puertomarinabenalmadena@riu.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.5114970207214355</Longitud>
        <Latitud>36.59885384270578</Latitud>
        <Descripcion>Location : Only 90 meters away from the beach and 200 meters away from the commercial center. Accommodation: 272 bedrooms with fully equipped bathroom, telephone, air conditioning, heating, ceiling fan, minibar, satellite TV, safe box, and terrace / balcony. Facilities and Services: Bar, hall, Internet, swimming pool (air-conditioned in winter), solarium, and bar in the swimming pool, entertainment activities. Catering: Buffet Breakfast and Dinner Additional Information: Inaugurated in summer 2005 n It offers the possibility of doing a wide variety of activities and sports in the neighbouring areas. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900531</Codigo>
        <Nombre>APTOS. JARDINES DEL GAMONAL</Nombre>
        <Direccion>C/ZODIACO, 7 BLQ 4 - LOCAL 6</Direccion>
        <Telefono>952447587</Telefono>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>2*</Categoria>
        <Longitud>-4.529510736465450</Longitud>
        <Latitud>36.59832842198930</Latitud>
        <Descripcion>Accommodation: Study with spacious room equipped with 2 beds and a sofa, TV, fully equipped kitchen, bathroom and terrace. 1- and 2- bedroom Apartments with 2 beds in the bedroom and double sofa bed in the room. Facilities and Services: Gardens, swimming pools, safe box, garage for renting, cleaning and towel change twice a week, and bedclothes change once a week. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900550</Codigo>
        <Nombre>HOLIDAY PALACE</Nombre>
        <Direccion>CTRA NAC - 340 KM. 215,6</Direccion>
        <Telefono>952579757 - rva</Telefono>
        <Email>reservas@holidayworld.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.585075378417969</Longitud>
        <Latitud>36.57633506453712</Latitud>
        <Descripcion>Accommodation: Junior Suite bedroom for 4 people equipped with satellite TV with remote control, daily change of towels, change of bedclothes twice a week, mini bar offering water and soft drinks with daily supply, room service. Facilities and Services: Swimming pools, hammocks, swimming pool towels, health club (10:00 n 14:00hs and 15:00- 19:00hs). Free access to Jacuzzi and gymnasium, all the other services must be paid in advance, Beach club (tennis, paddle, volleyball, basketball, football n free depending on availability), evening and childrenns entertainment, 24-hour reception, 24-hour medical service, cyber cafn, shopping-center, safe box. Catering: Restaurant The Gallery open for breakfast (8:00-10:30hs) and Dinner (18:30 n 21:30hs). The meals will be in Le Mirage restaurant (April n October, from 12:00 until 15:30hs). Bar Atlantis and Le Mirage in the Beach Club. Bar La Tahona and Snack Chambao in the hotel. Additional Information: Bus service to Beach Club from 10:00 to 18:00hs </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900561</Codigo>
        <Nombre>APTOS. LA HACIENDA</Nombre>
        <Direccion>AVDA. DE LA HACIENDA, 40 URB. LA HACIENDA</Direccion>
        <Telefono>952569053</Telefono>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>Apto.3LL</Categoria>
        <Longitud>-4.565548896789551</Longitud>
        <Latitud>36.596562637625595</Latitud>
        <Descripcion>Location : In a private housing estate, 1 km away from Benalmadena. Accommodation: 6 Apartments with 2 bedrooms, room with a single bed, fully equipped bathroom, electric stove and spacious terrace. 4 attics with the same equipment plus terrace with shower, 5 hammocks, table and panoramic views. 2 more Apartments with private garden. All the Apartments are equipped with air-conditioning, telephone, Internet, safe box, satellite TV, DVD service. Towel cleaning and change 3 times a week, bedclothes change twice a week, iron and ironing board. </Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900565</Codigo>
        <Nombre>SUNSET BEACH CLUB</Nombre>
        <Direccion>AVDA. DEL SOL, Nn 5</Direccion>
        <Telefono>952579400</Telefono>
        <Email>reservas@sunsetbeachclub.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>4*</Categoria>
        <Longitud>-4.571020603179930</Longitud>
        <Latitud>36.5784804033995</Latitud>
        <Descripcion>Location : Beachfront, 2.5 km away from the Port of Benalmndena and 8 km away from center of Fuengirola. Accommodation: Offers 553 Apartments from 37.3m2 recently restored with a room with sofa bed. Dining-room with table and 4 chairs, bedroom, fully equipped kitchen, bathroom and terrace overlooking the sea and the mountains, or interior patio, air-conditioning, safe box (extra payment), telephone and satellite TV. Facilities and Services: 2 swimming pools (1 of them air-conditioned in winter), childrenns swimming pool and childrenns playground, medical center, hairdresserns, beauty parlor, laundry and dry-cleanerns service, shopping-center, indoor garage and shops. Catering: Restaurant Oasis (Buffet breakfast, n la carte lunch and dinner), cocktail bar, room with panoramic view (open from 12:00 until the afternoon with the popular Happy Hour), bar by swimming pool, and coffee shop Playa Pierino (beachfront, decorated in tropical style)</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900577</Codigo>
        <Nombre>BETANIA</Nombre>
        <Direccion>CONTRERAS S/N AVDA ROCIO JURADO</Direccion>
        <Telefono>952577786</Telefono>
        <Email>recepcion@hotelbetania.es</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>2*</Categoria>
        <Longitud>-4.530830383300781</Longitud>
        <Latitud>36.59179051088516</Latitud>
        <Descripcion>Location : Next to the beach, 100 meters away from the park La Paloma and 600 meters from Port Merino, quiet surroundings with green spaces. Accommodation: It has 53 bedrooms overlooking the sea, half-boarding system, and solarium with view of the sea, TV rooms, and parabolic antenna. Catering: restaurant and coffee shop.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900597</Codigo>
        <Nombre>VISTA DE REY</Nombre>
        <Direccion>C/GUADALMEDINA S/N URB. TORREMUELLE</Direccion>
        <Telefono>952441717</Telefono>
        <Email>reservasvistaderey@aquaria-hotels.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.523513317108154</Longitud>
        <Latitud>36.60092103702007</Latitud>
        <Descripcion>Surrounded by green spaces, only a few meters away from the hotel. The apart-hotel Vista de Rey has 61 bedrooms, most of them overlooking the sea. 24-hour guest reception and service. Bar Corona: 8:00 n 24:00hs n Room service until 23:00hs n Free transport to the beach of Torremuelle- self-service laundry n garage n swimming pool- 24-hour medical service- luggage equipment for late check-outs. All the bedrooms have a sofa-bed, built-in cupboard, air-conditioning, and heating, satellite TV, safe box, fully equipped bathroom, terrace, telephone, fully equipped kitchen with glass-ceramics of 2 hot-plates, fridge, coffee-pot, water boiler, toast-maker, microwave, kitchen utensils for 4 meals.</Descripcion>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900630</Codigo>
        <Nombre>PLAZOLETA, HOTEL 2** BENALMADENA</Nombre>
        <Direccion>AVDA. JUAN LUIS PERALTA, S/N</Direccion>
        <Telefono>952448197</Telefono>
        <Email>plazoleta@fondahotel.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>2*</Categoria>
        <Longitud>-4.568632</Longitud>
        <Latitud>36.599548</Latitud>
        <Descripcion/>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900635</Codigo>
        <Nombre>LA FONDA, 3*** BENALMADENA</Nombre>
        <Direccion>C/ SANTO DOMINGO, 7</Direccion>
        <Telefono>952568273</Telefono>
        <Email>lafonda@fondahotel.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>3*</Categoria>
        <Longitud>-4.529521465301514</Longitud>
        <Latitud>36.58986090292927</Latitud>
        <Descripcion/>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900636</Codigo>
        <Nombre>DORAMAR, APTOS 3 LLAVES, BENALMADENA</Nombre>
        <Direccion>C/ CARRIL DEL SIROCO, 6</Direccion>
        <Telefono>952562708</Telefono>
        <Email>info@apartamentosdoramar.com</Email>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>Apto.3LL</Categoria>
        <Longitud>-4.520895481109619</Longitud>
        <Latitud>36.59704500224411</Latitud>
        <Descripcion/>
      </Establecimiento>
      <Establecimiento>
        <Codigo>CS900637</Codigo>
        <Nombre>TAMARINDOS, APTOS. 2 LLAVES</Nombre>
        <Direccion>C/ TAMARINDOS, 2</Direccion>
        <Telefono>952574081</Telefono>
        <Pais>00034</Pais>
        <NombrePais>Espana</NombrePais>
        <Provincia>029</Provincia>
        <NombreProvincia>MALAGA</NombreProvincia>
        <Poblacion>11</Poblacion>
        <NombrePoblacion>BENALMADENA</NombrePoblacion>
        <Categoria>Apto.2LL</Categoria>
        <Longitud>-4.517848491668701</Longitud>
        <Latitud>36.59726895622048</Latitud>
        <Descripcion/>
      </Establecimiento>
    </Establecimientos>
  </Respuesta>
</string>



}
