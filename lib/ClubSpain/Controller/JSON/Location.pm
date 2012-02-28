package ClubSpain::Controller::JSON::Location;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Flight);


=head2 suggest()

    Поиск-подсказка города по начальным буквам слова.
    Поиск может проводиться на кириллице, латинице или IATA коду города.
    Количесво букв для поиска - не менее трех.
    При меньшем количестве - поиск не выполняется.

=cut

sub suggest : Local {
    my ( $self, $c ) = @_;

    my $search = $c->request->param('term');
    my @res = $self->_suggest($c, $search);
    $c->stash(json_data => \@res);

    $c->forward('View::JSON');
}



#список стран отправлениия
sub getCountryOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->_getCountryOfDeparture($c);

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#список городов отправления
sub getCityOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->_getCityOfDeparture(
        $c, $c->request->param('countryOfDeparture')
    );

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#список аэропортов отправления
sub getAirportOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->_getAirportOfDeparture(
        $c, $c->request->param('cityOfDeparture')
    );

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#список стран прибытия
sub getCountryOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->_getCountryOfArrival($c);;

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#список городов прибытия
sub getCityOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->_getCityOfArrival($c, $c->request->param('countryOfArrival'));

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#список аэропортов прибытия
sub getAirportOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->_getAirportOfArrival($c, $c->request->param('cityOfArrival'));

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}

1;
