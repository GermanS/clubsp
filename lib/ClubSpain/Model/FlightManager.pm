package ClubSpain::Model::FlightManager;

use strict;
use warnings;

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

sub departing_country {
    my $class = shift;

    return [ $russia, $spain ];
}

sub departing_city {
    my ($class, $country) = @_;

    my @res;
    if ($country && $country == '2') {
        push @res, $bcn, $mal;
    } else {
        push @res, $mow;
    }

    return \@res;
}

sub destination_country {
    my ($class, $city) = @_;

    my @res;
    if ($city && $city == 1) {
        push @res, $spain;
    } else {
        push @res, $russia;
    }

    return \@res;
}

sub destination_city {
    my ($class, $destination_country) = @_;

    my @res;
    if ($destination_country && $destination_country == '1') {
        push @res, $mow;
    } else  {
        push @res, $bcn, $mal;
    }

    return \@res;
}

sub departing_date {
    my ($class, $params) = @_;

    return $departure->{$params->{'departing_city'}}{$params->{'destination_city'}};
}

sub returning_date {
    my ($class, $params) = @_;

    return $return->{$params->{'departing_city'}}{$params->{'destination_city'}}{$params->{'departing_date'}};
}

sub fare {
}

sub book {
}

1;
