package ClubSpain::Controller::XMLRPC;

use strict;
use warnings;

use base qw(Catalyst::Controller);

sub getCountryList : XMLRPC {
    my ($self, $c) = @_;

    my $iterator = $c->model('Country')->search({
        is_published => 1
    });

    my $reader = $c->model('Reader::Country')->new(resultset => $iterator);
    $c->stash(xmlrpc => $reader->read);
}

=head

sub getCityList : XMLRPC {
    my ($self, $c, $country) = @_;
    return unless $country;

    my $iterator = $c->model('City')->search({
        country_id   => $country,
        is_published => 1,
    });

    $c->stash(xmlrpc => \@res);
}

sub getAirportList : XMLRPC {
    my ($self, $c, $city) = @_;
    return unless $city;

    my $iterator = $c->model('DBIC::Airport')->search({
        city_id      => $city,
        is_published => 1,
    });

    my @res = $self->formater('Airport')->as_xml();
    $c->stash(xmlrpc => \@res);
}

=cut

sub end : Private {
}

1;
