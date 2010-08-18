package ClubSpain::Controller::Charter;

use strict;
use warnings;

use parent qw(Catalyst::Controller);

sub index :Path {
    my ($self, $c) = @_;

    $c->stash(template => 'charter/search.tt2');
}

1;
