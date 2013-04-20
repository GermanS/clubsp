package ClubSpain::XML::VipService::Import::Duration;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use ClubSpain::Types;

use DateTime;
use Moose;

has 'origin' => (
    is       => 'ro',
    required => 1,
);
has 'destination' => (
    is       => 'ro',
    required => 1,
);
has 'start' => (
    is       => 'ro',
    required => 1,
    isa      => 'DateTime',
    coerce   => 1
);
has 'end' => (
    is       => 'ro',
    required => 1,
    isa      => 'DateTime',
    coerce   => 1
);
has 'days' => (
    is       => 'ro',
    required => 1,
    traits   => [ 'Array' ],
    default  => sub { [] },
    handles  => {
        all_days => 'elements',
        filter   => 'grep',
        map_days => 'map',
    }
);

sub dates {
    my $self = shift;

    my @result;
    my $date = $self -> start -> clone();
    while ( DateTime -> compare( $date, $self -> end ) <= 0 )  {
        if ( $self -> filter( sub { $_ == $date -> day_of_week() } ) ) {

            push @result, {
                start => $date -> clone(),
                end   => $date -> clone() -> add( weeks => 1 )
            };

            foreach my $day ( $self -> all_days() ) {
                next if $day == $date -> day_of_week();

                push @result, {
                    start => $date -> clone(),
                    end   => $date -> clone() -> add( weeks => 1, days => ( $day - $date -> day_of_week_0() - 1 ) % 7    )
                };
            }

            push @result, {
                start => $date -> clone(),
                end   => $date -> clone() -> add( weeks => 2 )
            };
        }

        $date -> add( days => 1 );
    }

    return @result;
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__