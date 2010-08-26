package ClubSpain::View::TT;

use strict;
use warnings;

use parent qw(Catalyst::View::TT);

__PACKAGE__->config(
    ENCODING            => 'utf-8',
    TEMPLATE_EXTENSIOn  => 'tt2',
    PRE_CHOMP           => 2,
    POST_CHOMP          => 2,
    INCLUDE_PATH        => [ ClubSpain->path_to('root', 'base') ]
);

1;
