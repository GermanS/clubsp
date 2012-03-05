package ClubSpain::Controller::JSON::Location;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Location);


=head2 suggest()

    Поиск-подсказка города по начальным буквам слова.
    Поиск может проводиться на кириллице, латинице или IATA коду города.
    Количесво букв для поиска - не менее трех.
    При меньшем количестве - поиск не выполняется.

=cut

sub suggest :Local {
    my ( $self, $c ) = @_;

    my $search = $c->request->param('term');
    my @res = $self->next::method($search);
    $c->stash(json_data => \@res);
}



#список стран отправлениия
sub getCountryOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}



#список городов отправления
sub getCityOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        $c->request->param('countryOfDeparture')
    );
    $c->stash(json_data => \@res);
}



#список аэропортов отправления
sub getAirportOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        $c->request->param('cityOfDeparture')
    );
    $c->stash(json_data => \@res);
}



#список стран прибытия
sub getCountryOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}



#список городов прибытия
sub getCityOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        $c->request->param('countryOfArrival')
    );
    $c->stash(json_data => \@res);
}



#список аэропортов прибытия
sub getAirportOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        $c->request->param('cityOfArrival')
    );
    $c->stash(json_data => \@res);
}



sub end :Private {
    my ($self, $c) = @_;

    $c->forward('View::JSON');
}

1;
