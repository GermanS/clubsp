package ClubSpain::Controller::BackOffice;

use strict;
use warnings;
use utf8;
use parent qw(Catalyst::Controller);

# base sub for matching public path /account
# -- this verifies logged-in-ness for everything chained onto it
sub base :Chained("/") :PathPart('backoffice') :CaptureArgs(0) {
}


# display /backoffice page
sub root :Chained("base") :PathPart("") :Args(0) {
}

1;
