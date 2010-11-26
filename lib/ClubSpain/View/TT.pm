package ClubSpain::View::TT;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::View::TT);

__PACKAGE__->config(
    ENCODING            => 'UTF-8',
    TEMPLATE_EXTENSION  => 'tt2',
    PRE_CHOMP           => 2,
    POST_CHOMP          => 2,
    INCLUDE_PATH        => [ ClubSpain->path_to('root', 'base') ]
);

1;
