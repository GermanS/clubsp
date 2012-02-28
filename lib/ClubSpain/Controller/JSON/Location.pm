package ClubSpain::Controller::JSON::City;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC);


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

1;
