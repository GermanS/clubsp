package ClubSpain::Controller::Charter::Timetable;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller);

sub auto :Private {
    my ($self, $c) = @_;


    $c->stash(
        calendar  => $c->model('Calendar')->new(),
        template  => 'common/charter/timetable/timetable.tt2'
    );
}

sub default :Path { }

sub end :ActionClass('RenderView') {}

1;
