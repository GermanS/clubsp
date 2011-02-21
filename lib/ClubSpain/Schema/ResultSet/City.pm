package ClubSpain::Schema::ResultSet::City;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);


=head2 searchCitiesOfDeparture(counry => $country);

Получение списка городов отправления в которых
 - есть аэропорты
 - установлене флаг доступности is_published=1

 Внутренний метод, используемыый в бекофисе программы
 при работе с нумерацией рейсов.

=cut

sub searchCitiesOfDeparture {
    my ($self, %params) = @_;

    return
        unless $params{'country'};

    return
        $self->result_source->resultset->search({
            'country.is_published' => 1,
            'me.is_published'      => 1,
            'airport.is_published' => 1,
            'me.country_id'        => $params{'country'}
        }, {
            where => [ -and => {
                'me.country_id'   => \'=country.id',
                'airport.city_id' => \'=me.id'
            }],
            from     => [ 'city as me, airport, country' ],
            group_by => 'me.id',
        });
}


=head2 searchCitiesOfDepartureInFlight()

Получение списка городов отправления в которых
 - есть аэропорты
 - установлен флаг доступности is_published=1
 - есть авиарейс

=cut


sub searchCitiesOfDepartureInFlight {
    my $self = shift;
}

=head2 searchCitiesOfDepartureInTimeTable()

Получение списка городов отправления в которых
 - есть аэропорты
 - установлен флаг доступности is_published=1
 - есть авиарейс
 - есть расписание, даты отправления больше чем текущее число

=cut

sub searchCitiesOfDepartureInTimeTable {
    my $self = shift;


    return $self->result_source->resultset->search({}, {
    });
}

1;
