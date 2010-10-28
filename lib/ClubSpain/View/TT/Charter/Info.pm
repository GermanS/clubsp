package ClubSpain::View::TT::Charter::Info;

use strict;
use warnings;

use base qw(ClubSpain::View::TT);

sub process {
    my ($self, $c) = @_;

    $c->stash->{'template'} = 'charter/info.tt2';

    return $self->SUPER::process($c);
}

1;
