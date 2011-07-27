package ClubSpain::Schema::ResultSet::TimeTable;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::ResultSet);

my %Conditions = (
    'departure_country.is_published'    => 1,
    'destination_country.is_published'  => 1,
    'departure_city.is_published'       => 1,
    'destination_city.is_published'     => 1,
    'departure_airport.is_published'    => 1,
    'destination_airport.is_published'  => 1,
    'flight.is_published'               => 1,
    'me.is_published'                   => 1,
);

my %Where = (
    'departure_city.country_id '    => \'=departure_country.id',
    'departure_airport.city_id'     => \'=departure_city.id',
    'flight.departure_airport_id'   => \'=departure_airport.id',
    'flight.destination_airport_id' => \'=destination_airport.id',
    'destination_airport.city_id'   => \'=destination_city.id',
    'destination_city.country_id'   => \'=destination_country.id',
    'me.flight_id'                  => \'=flight.id',
);

my @From = qq(country as departure_country,
              country as destination_country,
              city as departure_city,
              city as destination_city,
              airport as departure_airport,
              airport as destination_airport,
              flight,
              timetable as me);

=head2 searchDatesOfDepature(cityOfDeparture => $city, cityOfArrival => $city, startDate => $date)

Получение дат отправления из города cityOfDeparture в город cityOfArrival
с момента времени startDate

все флаги должны быть выставлены в единицу

=cut

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    return
        unless $params{'cityOfDeparture'} && $params{'cityOfArrival'};

    my $startDate = $params{'startDate'}
                    ? sprintf ">'%s'", $params{'startDate'}
                    : '>= NOW()';

    return $self->result_source->resultset->search({
                %Conditions,
                'me.departure_date'   =>\$startDate,
                'departure_city.id'   => $params{'cityOfDeparture'},
                'destination_city.id' => $params{'cityOfArrival'}
    }, {
            where  => [ -and => \%Where],
            from     => \@From,
            group_by => 'me.departure_date'
    });
}

=head2 searchTimetable(cityOfDeparture =>, cityOfArrival => , dateOfDeparture =>, )

Получение расписания по критерию
cityOfDeparture - город отправление
cityOfArrival   - город прибытия
dateOfDeparture - дата отправления
flight          - идентификатор рейса (опционально)

на выходе iterator всех найденных вариантов удовлетворяющих критериям
или undef если не заданы обязательные параметры.

=cut

sub searchTimetable {
    my ($self, %params) = @_;

    return unless $params{'cityOfDeparture'} &&
                  $params{'cityOfArrival'}  &&
                  $params{'dateOfDeparture'};

    my %arguments = (
        'me.departure_date'     => $params{'dateOfDeparture'},
        'departure_city.id'     => $params{'cityOfDeparture'},
        'destination_city.id'   => $params{'cityOfArrival'}
    );
    $arguments{'me.flight_id'} = $params{'flight'}
        if $params{'flight'};

    return $self->result_source->resultset->search({
            %Conditions,
            %arguments
    }, {
            where  => [ -and => \%Where ],
            from     => \@From
    });
}

=head2 departures(cityOfDeparture => , duration => )

Получение расписание вылетов из указанного города начиная с текущего момента
плюс колическов указанных дней
На входе:
cityOfDeparture - город вылета
duration  - количество дней за которое необходимо паказать расписание
       необязательный параметр

=cut

sub departures {
    my ($self, %params) = @_;

    return unless $params{'cityOfDeparture'};

    my %arguments = (
        'me.departure_date' => \'>NOW()',
        'departure_city.id' => $params{'cityOfDeparture'},
    );

    my $duration = $params{'duration'};
    $Where{'me.departure_date'} = \"<ADDDATE(NOW(), $duration)"
        if defined $duration && $duration;

    return $self->result_source->resultset->search({
            %Conditions,
            %arguments
    }, {
            where  => [ -and => \%Where ],
            from     => \@From,
            order_by => [ 'me.departure_date', 'me.departure_time' ]
    })
}

=head2 arrivals(cityOfArrival => , duration => )

Получение расписания прилетов в указанный город начиная с текущего момента
плюс колическов указанных дней
На входе:
cityOfФккшмфд - город прилета
duration  - количество дней за которое необходимо паказать расписание
       необязательный параметр

=cut

sub arrivals {
    my ($self, %params) = @_;

    return unless $params{'cityOfArrival'};

    my %arguments = (
        'me.departure_date' => \'>NOW()',
        'destination_city.id' => $params{'cityOfArrival'},
    );

    my $duration = $params{'duration'};
    $Where{'me.departure_date'} = \"<ADDDATE(NOW(), $duration)"
        if defined $duration && $duration;

    return $self->result_source->resultset->search({
            %Conditions,
            %arguments
    }, {
            where    => [ -and => \%Where ],
            from     => \@From,
            order_by => [ 'me.arrival_date', 'me.arrival_time' ]
    })
}

1;
