package ClubSpain::Build;

use strict;
use warnings;
use feature qw(say switch);

use base qw(Module::Build);

use LWP::UserAgent;
use HTTP::Request::Common;

use ClubSpain::XML::Terramar::Request::Language;
use ClubSpain::XML::Terramar::Request::ProductClassification;
use ClubSpain::XML::Terramar::Request::ProductType;
use ClubSpain::XML::Terramar::Request::Country;
use ClubSpain::XML::Terramar::Request::Zona;
use ClubSpain::XML::Terramar::Request::Province;
use ClubSpain::XML::Terramar::Request::City;
use ClubSpain::XML::Terramar::Request::Hotel;
use ClubSpain::XML::Terramar::Request::HotelInfo;
use ClubSpain::XML::Terramar::Request::BoardType;
use ClubSpain::XML::Terramar::Request::Occupation;
use ClubSpain::XML::Terramar::Request::HotelAvailability;
use ClubSpain::XML::Terramar::Request::HotelContract;
use ClubSpain::XML::Terramar::Request::HotelActiveContract;

sub ACTION_request_menu {
    my $self = shift;

    $self->depends_on('build');

    $self->args('login',
        $self->prompt('Type login to web service (login):')
    ) unless $self->args('login');

    $self->args('pass',
        $self->prompt('Type password to web service (pass):')
    ) unless $self->args('pass');

    $self->args('dominio',
        $self->prompt('Type domain to web service (dominio):')
    ) unless $self->args('dominio');

    while (1) {
        say "=" x 25;
        say "[1] request_language";
        say "[2] request_product_classification";
        say "[3] request_product_type";
        say "[4] request_country";
        say "[5] request_zone";
        say "[6] request_province";
        say "[7] request_city";
        say "[8] request_hotel";
        say "[9] request_hotel_info";
        say "[10] request_board_type";
        say "[11] request_occupation";
        say "[12] request_hotel_availability";
        say "[13] request_hotel_active_contract";
        say "[14] request_hotel_contract_details";
        say "[0] Main menu";
        say "type quit to exit";
        say "-" x 25;
        $self->args('menu', $self->prompt("Your choice: ", 0));
        say "-" x 25;

        given ($self->args('menu')) {
            when ('quit') { exit(0); }
            when (1) { $self->ACTION_request_language(); }
            when (2) { $self->ACTION_request_product_classification(); }
            when (3) { $self->ACTION_request_product_type(); }
            when (4) { $self->ACTION_request_country(); }
            when (5) { $self->ACTION_request_zona(); }
            when (6) { $self->ACTION_request_province(); }
            when (7) { $self->ACTION_request_city(); }
            when (8) { $self->ACTION_request_hotel(); }
            when (9) { $self->ACTION_request_hotel_info(); }
            when (10) { $self->ACTION_request_board_type(); }
            when (11) { $self->ACTION_request_occupation(); }
            when (12) { $self->ACTION_request_hotel_availability(); }
            when (13) { $self->ACTION_hotel_active_contract(); }
            when (14) { $self->ACTION_hotel_contract_details(); }
        }
    }
}

sub ACTION_request_language {
    my $self = shift;

    my $xml = ClubSpain::XML::Terramar::Request::Language->request();
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_product_classification {
    my $self = shift;

    say "-" x 25;
    $self->args('id_idioma', $self->prompt('Language ID (id_idioma):'));
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::ProductClassification->request(
        id_idioma => $self->args('id_idioma')
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_product_type {
    my $self = shift;

    say "-" x 25;
    $self->args('id_idioma',
        $self->prompt('Language ID (id_idioma):')
    );
    $self->args('id_tipo_articulo_superclase',
        $self->prompt('Product supertype ID (id_tipo_articulo_superclase):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::ProductType->request(
        id_idioma                   => $self->args('id_idioma'),
        id_tipo_articulo_superclase => $self->args('id_tipo_articulo_superclase')
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_country {
    my $self = shift;

    say "-" x 25;
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::Country->request(
        id_tipo_articulo_clase => $self->args('id_tipo_articulo_clase')
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_zona {
    my $self = shift;

    say "-" x 25;
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase):')
    );
    $self->args('id_zona_pais',
        $self->prompt('Country ID (id_zona_pais):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::Zona->request(
        id_tipo_articulo_clase => $self->args('id_tipo_articulo_clase'),
        id_zona_pais           => $self->args('id_zona_pais'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_province {
    my $self = shift;

    say "-" x 25;
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase):')
    );
    $self->args('id_zona',
        $self->prompt('Zona ID (id_zona):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::Province->request(
        id_tipo_articulo_clase => $self->args('id_tipo_articulo_clase'),
        id_zona                => $self->args('id_zona'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_city {
    my $self = shift;

    say "-" x 25;
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase):')
    );
    $self->args('id_zona',
        $self->prompt('Zona ID (id_zona):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::City->request(
        id_tipo_articulo_clase => $self->args('id_tipo_articulo_clase'),
        id_zona                => $self->args('id_zona'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_hotel {
    my $self = shift;

    say "-" x 25;
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase):')
    );
    $self->args('id_idioma',
        $self->prompt('Language ID (id_idioma):')
    );
    $self->args('poblacion',
        $self->prompt('City ID (poblacion):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::Hotel->request(
        id_tipo_articulo_clase => $self->args('id_tipo_articulo_clase'),
        id_idioma              => $self->args('id_idioma'),
        poblacion              => $self->args('poblacion'),
        info_extendida         => 0
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_hotel_info {
    my $self = shift;

    say "-" x 25;
    $self->args('id_prestatario',
        $self->prompt('Hotel ID (id_prestatario):')
    );
    $self->args('id_idioma',
        $self->prompt('Language ID (id_idioma):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::HotelInfo->request(
        id_prestatario  => $self->args('id_prestatario'),
        id_idioma       => $self->args('id_idioma'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);
}

sub ACTION_request_board_type {
    my $self = shift;

    say "-" x 25;
    $self->args('id_idioma',
        $self->prompt('Language ID (id_idioma):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::BoardType->request(
        id_idioma       => $self->args('id_idioma'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);    
}

sub ACTION_request_occupation {
    my $self = shift;
    
    say "-" x 25;
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::Occupation->request(
        id_tipo_articulo_clase  => $self->args('id_tipo_articulo_clase'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);        
}

sub ACTION_request_hotel_availability {
    my $self = shift;
    
    say "-" x 25;
    $self->args('id_articulo',
        $self->prompt('Hotel ID (id_articulo):')
    );
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::HotelAvailability->request(
        id_articulo       => $self->args('id_articulo'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response); 
}

sub ACTION_hotel_active_contract {
    my $self = shift;
    
    say "-" x 25;
    $self->args('id_prestatario',
        $self->prompt('Hotel ID (id_articulo):')
    );
    $self->args('id_idioma',
        $self->prompt('Language ID (id_idioma):')
    );    
    $self->args('id_tipo_articulo_clase',
        $self->prompt('Product type ID (id_tipo_articulo_clase)::')
    );        
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::HotelActiveContract->request(
        id_prestatario         => $self->args('id_prestatario'),
        id_idioma              => $self->args('id_idioma'),
        id_tipo_articulo_clase => $self->args('id_tipo_articulo_clase'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response);     
}

sub ACTION_hotel_contract_details {
    my $self = shift;
    
    say "-" x 25;
    $self->args('id_articulo',
        $self->prompt('Hotel ID (id_articulo):')
    );
    $self->args('id_idioma',
        $self->prompt('Language ID (id_idioma):')
    );    
    say "-" x 25;

    my $xml = ClubSpain::XML::Terramar::Request::HotelContract->request(
        id_articulo       => $self->args('id_articulo'),
        id_idioma         => $self->args('id_idioma'),
    );
    my $response = $self->ua->request( $self->uri($xml) );

    $self->out($response); 
}

sub out {
    my ($self, $response) = @_;

    if ($response->is_success) {
        print $response->content();
    } else {
        print $response->status_line();
    }
}

sub uri {
    my ($self, $xml) = @_;

    return POST 'http://tmt.terramartour.com/owbooking/index.php', [
        login      => $self->args('login'),
        pass       => $self->args('pass'),
        dominio    => $self->args('dominio'),
        owb_modulo => 'ws',
        owb_vista  => 'integracion',
        xml_integracion_ws => $xml
    ];
}

sub ua {
    return LWP::UserAgent->new();
}

1;
