package ClubSpain::Model::FlightManager;

use strict;
use warnings;

use ClubSpain::Model::Ticket;
use ClubSpain::Model::Ticket::Segment;

my $russia = new ClubSpain::Model::Country({ id => 1, name => 'Россия',  code => 'ru' });
my $spain  = new ClubSpain::Model::Country({ id => 2, name => 'Испания', code => 'es' });

my $mow = new ClubSpain::Model::City({ id => 1, code => 'mow', name => 'Москва' });
my $bcn = new ClubSpain::Model::City({ id => 2, code => 'bcn', name => 'Барселона' });
my $mal = new ClubSpain::Model::City({ id => 3, code => 'mal', name => 'Малага' });

my $departure = {
    1 => {
        2 => [
            new ClubSpain::Model::Date({ id => '04-09-2010', name => '04-09-2010'}),
            new ClubSpain::Model::Date({ id => '11-09-2010', name => '11-09-2010'}),
            new ClubSpain::Model::Date({ id => '18-09-2010', name => '18-09-2010'}),
            new ClubSpain::Model::Date({ id => '25-09-2010', name => '25-09-2010'}),
        ],
        3 => [
            new ClubSpain::Model::Date({ id => '12-10-2010', name => '12-10-2010'}),
            new ClubSpain::Model::Date({ id => '19-10-2010', name => '19-10-2010'}),
            new ClubSpain::Model::Date({ id => '26-10-2010', name => '26-10-2010'}),
        ]
    },
    2  => {
        1 => [
            new ClubSpain::Model::Date({ id => '04-09-2010', name => '04-09-2010'}),
            new ClubSpain::Model::Date({ id => '11-09-2010', name => '11-09-2010'}),
            new ClubSpain::Model::Date({ id => '18-09-2010', name => '18-09-2010'}),
            new ClubSpain::Model::Date({ id => '25-09-2010', name => '25-09-2010'}),
        ]
    },
    3 => {
        1 => [
            new ClubSpain::Model::Date({ id => '12-10-2010', name => '12-10-2010'}),
            new ClubSpain::Model::Date({ id => '19-10-2010', name => '19-10-2010'}),
            new ClubSpain::Model::Date({ id => '26-10-2010', name => '26-10-2010'}),
        ]
    }
};

my $return = {
    2 => {
        1 => {
            '04-09-2010' => [
                new ClubSpain::Model::Date({ id => '11-09-2010', name => '11-09-2010'}),
                new ClubSpain::Model::Date({ id => '18-09-2010', name => '18-09-2010'}),
            ],
            '11-09-2010' => [
                new ClubSpain::Model::Date({ id => '18-09-2010', name => '18-09-2010'}),
                new ClubSpain::Model::Date({ id => '25-09-2010', name => '15-09-2010'}),
            ],
            '18-09-2010' => [
                new ClubSpain::Model::Date({ id => '25-09-2010', name => '25-09-2010'}),
            ],
            '25-09-2010' => [
                new ClubSpain::Model::Date({ id => '03-10-2010', name => '03-10-2010'}),
            ]
        }
    },
    3 => {
        1 => {
            '12-10-2010' => [
                new ClubSpain::Model::Date({ id => '19-10-2010', name => '19-10-2010'}),
                new ClubSpain::Model::Date({ id => '26-10-2010', name => '26-10-2010'}),
            ],
            '19-10-2010' => [
                new ClubSpain::Model::Date({ id => '26-10-2010', name => '26-10-2010'}),
            ],
            '26-10-2010' => [
                new ClubSpain::Model::Date({ id => '03-11-2010', name => '03-11-2010'}),
                new ClubSpain::Model::Date({ id => '10-11-2010', name => '10-11-2010'}),
                new ClubSpain::Model::Date({ id => '17-11-2010', name => '17-11-2010'}),
            ]
        }
    },
    1 => {
        2 => {
            '04-09-2010' => [
                new ClubSpain::Model::Date({ id => '11-09-2010', name => '11-09-2010'}),
                new ClubSpain::Model::Date({ id => '18-09-2010', name => '18-09-2010'}),
                new ClubSpain::Model::Date({ id => '25-09-2010', name => '25-09-2010'}),
            ],
            '11-09-2010' => [
                new ClubSpain::Model::Date({ id => '18-09-2010', name => '18-09-2010'}),
                new ClubSpain::Model::Date({ id => '25-09-2010', name => '25-09-2010'}),
            ],
            '25-09-2010' => [
                new ClubSpain::Model::Date({ id => '02-10-2010', name => '02-10-2010'}),
            ]
        },
        3 => {
            '12-10-2010' => [
                new ClubSpain::Model::Date({ id => '19-10-2010', name => '19-10-2010'}),
                new ClubSpain::Model::Date({ id => '26-10-2010', name => '26-10-2010'}),
            ],
            '19-10-2010' => [
                new ClubSpain::Model::Date({ id => '26-10-2010', name => '26-10-2010'}),
            ],
            '26-10-2010' => [
                new ClubSpain::Model::Date({ id => '10-11-2010', name => '10-11-2010'}),
                new ClubSpain::Model::Date({ id => '17-11-2010', name => '17-11-2010'}),
            ]
        }
    }
};

my $ticket = ClubSpain::Model::Ticket->new({
    segment => [
        new ClubSpain::Model::Ticket::Segment({
            departure_date      => '10-11-2010',
            departure_time      => '12:30',
            departure_airport   => 'DME',
            departure_city      => 'Moscow',
            departure_country   => 'Russia',
            arrival_date        => '10-11-2010',
            arrival_time        => '14:30',
            arrival_airport     => 'BCN',
            arrival_city        => 'Barcelona',
            arrival_country     => 'Spain',
            flight => {
                carrier => {
                    name => 'Vim-Avia',
                    iata => 'NN',
                    icao => 'NN'
                },
                plane => {
                    designator => 'B52',
                    model      => 'B 52'
                },
                flight => {
                    code               => 331,
                    operational_suffix => ''
                },
                class => 'Y'
            }
        })
    ],
    price => 100,
});

sub departure_country {
    my $class = shift;

    return [ $russia, $spain ];
}

sub departure_city {
    my ($class, $params) = @_;

    my @res;
    my $country = $params->{'departure_county'};
    if ($country && $country == '2') {
        push @res, $bcn, $mal;
    } else {
        push @res, $mow;
    }

    return \@res;
}

sub arrival_country {
    my ($class, $params) = @_;

    my @res;
    my $city = $params->{'departure_city'};
    if ($city && $city == 1) {
        push @res, $spain;
    } else {
        push @res, $russia;
    }

    return \@res;
}

sub arrival_city {
    my ($class, $params) = @_;

    my @res;
    my $arrival_country = $params->{'arrival_country'};
    if ($arrival_country && $arrival_country == '1') {
        push @res, $mow;
    } else  {
        push @res, $bcn, $mal;
    }

    return \@res;
}

sub departure_date {
    my ($class, $params) = @_;

    return $departure->{$params->{'departure_city'}}{$params->{'arrival_city'}};
}

sub return_date {
    my ($class, $params) = @_;

    return $return->{$params->{'departure_city'}}{$params->{'arrival_city'}}{$params->{'departure_date'}};
}

sub fare {
    my ($class, $params) = @_;

    return $ticket;
}

sub book {
}

1;
