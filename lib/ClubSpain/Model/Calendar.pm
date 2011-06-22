package ClubSpain::Model::Calendar;

use Moose;
use namespace::autoclean;
use utf8;

use DateTime;
use DateTime::Format::MySQL;

use ClubSpain::Model::Calendar::Settings;
use ClubSpain::Model::Calendar::Header;
use ClubSpain::Model::Calendar::Month;

has 'settings' => (
    is   => 'rw',
    isa  => 'ClubSpain::Model::Calendar::Settings',
    default => sub {
        ClubSpain::Model::Calendar::Settings->new()
    }
);

has 'header' => (
    is   => 'rw',
    isa  => 'ClubSpain::Model::Calendar::Header',
    default => sub {
        ClubSpain::Model::Calendar::Header->new()
    }
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


    my @months = ();
    my $start = $self->start->clone();
    while (DateTime->compare($self->end, $start)) {
        push @months, ClubSpain::Model::Calendar::Month->new( date => $start->clone() );
        $start->add( months => 1 );
    }

    $self->months(\@months);
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

=head

sub create {
    my $self = shift;

    my @res = ();
    my $start = $self->start->clone();

    while (DateTime->compare($self->end, $start)) {
        push @res,
            ClubSpain::Model::Calendar::Month->new( date => $start );

        $start->add( months => 1 );
    }

    return @res;
}

=cut

__PACKAGE__->meta->make_immutable;

1;



=head

sub format_months {
    my $self = shift;

    my $dt = $self->start;
    my @months = ();
    my $count = 0;

    while ( $count < $self->settings->months ) {
        my $length = $dt->month + $count - 1;
        push @months,
            $dt->{'locale'}->month_stand_alone_wide->[ $length % 12 ];

        $count++;
    }

    return @months;
}

=cut
