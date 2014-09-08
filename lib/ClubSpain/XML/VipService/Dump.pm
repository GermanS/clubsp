package ClubSpain::XML::VipService::Dump;

use namespace::autoclean;
use strict;
use warnings;
use utf8;

use Moose;
use File::Slurp;

has [ 'airport_of_departure', 'airport_of_arrival' ] => ( is => 'ro', required => 1 );
has [ 'date_of_departure', 'date_of_arrival' ]       => ( is => 'ro', required => 1 );
has 'content' => ( is => 'rw' );

sub save {
    my $self = shift;

    my $filename = sprintf "%s_%s_%s_%s", $self -> airport_of_departure(),
                                          $self -> airport_of_arrival(),
                                          $self -> date_of_departure(),
                                          $self -> date_of_arrival();

    write_file( $filename, $self -> content() );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__