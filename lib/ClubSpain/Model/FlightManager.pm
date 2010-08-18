package ClubSpain::Model::FlightManager;

use strict;
use warnings;

my $russia = new ClubSpain::Model::Country({ name => 'Россия',  code => 'ru' });
my $mow    = new ClubSpain::Model::City({ name => 'Москва', code => 'mow' });

my $spain = new ClubSpain::Model::Country({ name => 'Испания', code => 'es' });
my $bcn   = new ClubSpain::Model::City({ code => 'bcn', name => 'Барселона' });
my $mal   = new ClubSpain::Model::City({ code => 'mal', name => 'Малага' });

sub departure_countries {
    my $class = shift;

    return [ $russia, $spain ]
}

sub departure_cities {
    my ($class, $country) = shift;

    my @res;
    if ($country && $country eq 'es') {
        push @res, $bcn, $mal;
    } else {
        push @res, $mow;
    }

    return \@res;
}

sub arrival_countries {
    my ($class, $departure) = @_;

    my @res;
    if ($departure && $departure eq 'es') {
        push @res, $russia;
    } else {
        push @res, $spain;
    }

    return \@res;
}

sub arrival_cities {
    my ($class, $arrival) = @_;

    my @res;
    if ($arrival && $arrival eq 'ru') {
        push @res, $mow;
    } else  {
        push @res, $bcn, $mal;
    }

    return \@res;
}

sub departure_dates {
}

sub arrival_dates {
}

sub fare {
}

sub book {
}

1;
