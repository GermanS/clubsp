package ClubSpain::Controller::BackOffice::FormFu;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);

use ClubSpain::Constants qw(:all);
use ClubSpain::Message;

sub end :ActionClass('RenderView') {
};

sub process_error {
    my ($self, $c, $e) = @_;

    if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $c->stash( message => ClubSpain::Message->warning( $e->message ) );
    } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $c->stash( message => ClubSpain::Message->error( $e->message ));
    } else {
        $c->stash( message => ClubSpain::Message->error( $@ ) );
    }
};

sub successful_message {
    my ($self, $c) = @_;

    $c->stash( message => ClubSpain::Message->ok( MESSAGE_OK ) );
};

1;
