package ClubSpain::Model::Calendar::Month;

use Moose;
use namespace::autoclean;
use utf8;

has 'date'  => ( is => 'rw', isa => 'DateTime', required => 1 );
has 'dates' => ( is => 'rw' );

sub locale { shift->date->locale; }

=head2 format($datetime)

Получение названия месяца в именительном падеже.

на входе:
   $datetime - объект типа DateTime
на выходе:
   Название месяца

=cut

sub format {
    my $self = shift;

    my $dt = $self->date();
    return $dt->{'locale'}->month_stand_alone_wide->[ $dt->month_0 ];
}



=head2 month_length($datetime)

Получение количества дней в месяце

на входе:
   $datetime - объект типа DateTime
на выходе:
   Количество дней в месяце

=cut

sub month_length {
    my $self = shift;

    my $dt = $self->date();
    return DateTime->_month_length($dt->year, $dt->month);
}

=head2 calendar_length($datetime)

Длительность месяца в календаре

на входе
   $datetime - объект типа DateTime
на выходе
   длительность месяца со смещением на день недели

=cut

sub calendar_length {
    my $self = shift;

    return
        $self->first->day_of_week +
        $self->month_length() - 1;
}

=head2 first()

Первый день месяца
На выходе:
  объект типа DateTime

=cut

sub first {
    my $self = shift;

    return DateTime->new(
        year   => $self->date->year,
        month  => $self->date->month,
        day    => 1,
        locale => $self->locale,
    );
}

=head2 days()

Получение массава дат календаря
На выходе
  ссылка на массив дат в формате DateTime

=cut

sub days {
    my $self = shift;

    my $offset = $self->first->day_of_week-2;
    my $length = $self->month_length;

    my @days = ();
    for my $day (1 .. $length) {
        my $dt = DateTime->new(
            year   => $self->date->year,
            month  => $self->date->month,
            day    => $day,
            locale => $self->locale
        );

        $days[ $offset  + $dt->day ] = $dt;
    }

    $self->dates(\@days);
    return \@days;
}

__PACKAGE__->meta->make_immutable;

1;
