use Test::More tests => 2;

use strict;
use warnings;

use Test::MockObject;
my $mock = Test::MockObject -> new();
$mock -> fake_module(
    'ClubSpain::XML::VipService::Flight',
    count_adults => sub { 1 },
);

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch' );
use_ok( 'ClubSpain::XML::VipService::Import::Store' );

my $store = ClubSpain::XML::VipService::Import::Store -> new(
    response => [
        ClubSpain::XML::VipService::Response::FlightSearch -> new(
            response => response(),
            request  => $mock,
        )
    ]
);
isa_ok( $store, 'ClubSpain::XML::VipService::Import::Store' );

sub response {
    return {
    'parameters' => {
        'return' => {
            'messages' => {},
            'flights' => {
                'flight' => [{
                    'timeLimit' => '2011-09-28T00:00:00+04:00',
                    'carrier' => {
                        'name' => 'Iberia - Lineas Aereas de Espana',
                        'code' => 'IB'
                    },
                    'latinRegistration' => 1,
                    'eticket' => 1,
                    'price' => {
                        'price' => [{
                            'amount' => bless( { '_m' => [ 361 ], '_es' => '+', '_e' => [ 1 ], 'sign' => '+' }, 'Math::BigFloat' ),
                            'elementType' => 'TARIFF',
                            'passengerType' => 'ADULT'
                         },
                         {
                            'amount' => bless( { '_m' => [ '5255' ], '_es' => '+', '_e' => [ 0 ], 'sign' => '+' }, 'Math::BigFloat' ),
                            'elementType' => 'TAXES',
                            'passengerType' => 'ADULT'
                         }]
                    },
                    'segments' => {
                        'segment' => [{
                            'connected' => 0,
                            'locationBegin' => {
                                'name' => "Домодедово",
                                'code' => 'DME'
                            },
                            'dateEnd' => '2011-10-01T08:30:00+04:00',
                            'board' => {
                                'name' => "\x{410}320",
                                'code' => '320'
                            },
                            'starting' => 1,
                            'bookingClass' => 'P',
                            'travelDuration' => 270,
                            'serviceClass' => 'ECONOMY',
                            'dateBegin' => '2011-10-01T06:00:00+04:00',
                            'flightNumber' => '5786',
                            'airline' => {
                                'name' => 'Iberia - Lineas Aereas de Espana',
                                'code' => 'IB'
                            },
                            'locationEnd' => {
                                'name' => "Барселона",
                                'code' => 'BCN'
                            }
                       }, {
                            'connected' => 1,
                            'locationBegin' => {
                                'name' => "Барселона",
                                'code' => 'BCN'
                            },
                            'dateEnd' => '2011-10-16T05:10:00+04:00',
                            'board' => {
                                'name' => "\x{410}320",
                                'code' => '320'
                            },
                            'starting' => 1,
                            'bookingClass' => 'P',
                            'travelDuration' => 255,
                            'serviceClass' => 'ECONOMY',
                            'dateBegin' => '2011-10-15T22:55:00+04:00',
                            'flightNumber' => '5785',
                            'airline' => {
                                'name' => 'Iberia - Lineas Aereas de Espana',
                                'code' => 'IB'
                            },
                            'locationEnd' => {
                                'name' => "Домодедово",
                                'code' => 'DME'
                            }
                        }]
                    },
                }, {
                    'timeLimit' => '2011-09-29T00:00:00+04:00',
                    'carrier' => {
                        'name' => 'Air Europa Lineas Aereas, S.A.',
                        'code' => 'UX'
                    },
                    'latinRegistration' => 1,
                    'eticket' => 1,
                    'price' => {
                        'price' => [{
                            'amount' => bless( { '_m' => [125], '_es' => '+', '_e' => [2], 'sign' => '+' }, 'Math::BigFloat' ),
                            'elementType' => 'TARIFF',
                            'passengerType' => 'ADULT'
                         }, {
                            'amount' => bless( { '_m' => [ '4985' ], '_es' => '+', '_e' => [0], 'sign' => '+' }, 'Math::BigFloat' ),
                            'elementType' => 'TAXES',
                            'passengerType' => 'ADULT'
                         }]
                    },
                    'segments' => {
                        'segment' => [{
                            'connected' => 0,
                            'locationBegin' => {
                                'name' => "Шереметьево",
                                'code' => 'SVO'
                            },
                            'dateEnd' => '2011-10-01T22:45:00+04:00',
                            'board' => {
                                'name' => '{com.gridnine.xtrip.common.model.dict.AircraftReference: code=32S}',
                                'code' => '32S'
                            },
                            'starting' => 1,
                            'bookingClass' => 'U',
                            'travelDuration' => 255,
                            'serviceClass' => 'ECONOMY',
                            'dateBegin' => '2011-10-01T20:30:00+04:00',
                            'flightNumber' => '3288',
                            'airline' => {
                                'name' => 'Air Europa Lineas Aereas, S.A.',
                                'code' => 'UX'
                            },
                            'locationEnd' => {
                                'name' => "Барселона",
                                'code' => 'BCN'
                            }
                        }, {
                            'connected' => 1,
                            'locationBegin' => {
                                'name' => "Барселона",
                                'code' => 'BCN'
                             },
                            'dateEnd' => '2011-10-16T06:00:00+04:00',
                            'board' => {
                                'name' => '{com.gridnine.xtrip.common.model.dict.AircraftReference: code=32S}',
                                'code' => '32S'
                            },
                            'starting' => 1,
                            'bookingClass' => 'U',
                            'travelDuration' => 255,
                            'serviceClass' => 'ECONOMY',
                            'dateBegin' => '2011-10-15T23:45:00+04:00',
                            'flightNumber' => '3289',
                            'airline' => {
                                'name' => 'Air Europa Lineas Aereas, S.A.',
                                'code' => 'UX'
                            },
                            'locationEnd' => {
                                 'name' => "Шереметьево",
                                 'code' => 'SVO'
                                }
                            }]
                        },
                    }]
                }
            }
        }
    }
};