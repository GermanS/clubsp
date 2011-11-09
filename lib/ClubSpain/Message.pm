package ClubSpain::Message;
use Moose;
use namespace::autoclean;

has 'class'   => ( is => 'ro' );
has 'message' => ( is => 'ro', required => 1);

sub ok {
    my ($class, $message) = @_;

    return ClubSpain::Message::Ok->new(message => $message);
}

sub info {
    my ($class, $message) = @_;

    return ClubSpain::Message::Info->new(message => $message);
}

sub warning {
    my ($class, $message) = @_;

    return ClubSpain::Message::Warning->new(message => $message);
}

sub error {
    my ($class, $message) = @_;

    return ClubSpain::Message::Error->new(message => $message);
}


package ClubSpain::Message::Ok;
use Moose;
use namespace::autoclean;
extends 'ClubSpain::Message';

has 'class' => ( is => 'ro', default => 'success' );



package ClubSpain::Message::Info;
use Moose;
use namespace::autoclean;
extends 'ClubSpain::Message';

has 'class' => ( is => 'ro', default => 'info' );



package ClubSpain::Message::Warning;
use Moose;
use namespace::autoclean;
extends 'ClubSpain::Message';

has 'class' => (is => 'ro', default => 'warning' );



package ClubSpain::Message::Error;
use Moose;
use namespace::autoclean;
extends 'ClubSpain::Message';

has 'class' => (is => 'ro', default => 'error' );



__PACKAGE__->meta->make_immutable;

1;
