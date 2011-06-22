package ClubSpain::Model::Calendar;

use Moose;
use namespace::autoclean;
use utf8;

use DateTime;

use ClubSpain::Model::Calendar::Settings;
use ClubSpain::Model::Calendar::Month;

has 'settings' => (
    is   => 'rw',
    isa  => 'ClubSpain::Model::Calendar::Settings',
    default => sub {
        ClubSpain::Model::Calendar::Settings->new()
    }
);

has 'days_of_week' => (
    is   => 'rw',
    isa  => 'ArrayRef',
);

has 'start'  => ( is => 'rw' );
has 'end'    => ( is => 'rw' );
has 'months' => ( is => 'rw', isa => 'ArrayRef' );

sub BUILD {
    my ($self, $params) = @_;

    my $now = $self->now();

    unless ( $params->{'start'})  {
        $self->start(
            DateTime->new(
                year   => $now->year,
                month  => $now->month,
                day    => 1,
                locale => $self->settings->locale,
            )
        );
    }

    unless ( $params->{'end'} ) {
        $self->end(
            $self->start()->clone()->add( months => $self->settings->months )
        );
    }


    #months
    my @months = ();
    my $start = $self->start->clone();
    while (DateTime->compare($self->end, $start)) {
        push @months, ClubSpain::Model::Calendar::Month->new( date => $start->clone() );
        $start->add( months => 1 );
    }
    $self->months(\@months);


    my $count = 0;
    my @days  = ();
    my $length = $self->length();
    while ($count < $length) {
        push @days, $self->start->{'locale'}->day_format_abbreviated->[$count % 7];

        $count++;
    }

    $self->days_of_week(\@days);
}



sub now {
    my $self = shift;

    return DateTime->now( locale => $self->settings->locale );
}


=head2 length()

Получение количества столбцов календаря между дат начала и окончания

=cut


sub length {
    my $self = shift;

    my $length = 0;
    my $start = $self->start()->clone();

    while (DateTime->compare($self->end(), $start) > 0) {
        my $month = ClubSpain::Model::Calendar::Month->new(date => $start);
        my $duration = $month->calendar_length();

        $length =
            ($duration > $length) ? $duration : $length;

        $start->add( months => 1 );
    }

    return $length;
}


__PACKAGE__->meta->make_immutable;

1;
