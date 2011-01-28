package ClubSpain::Controller::JSONRPC;

use strict;
use warnings;

use base qw(Catalyst::Controller);

sub getCountryList : JSONRPCLocal {
    my ($self, $c) = @_;

    my $iterator = $c->model('Country')->search({
        is_published => 1
    });

    my $reader = $c->model('Reader::Country')->new(resultset => $iterator);
    $c->stash->{'jsonrpc'} = $reader->read;
}

sub end : Private {
}

1;
