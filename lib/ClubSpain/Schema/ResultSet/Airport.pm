package ClubSpain::Schema::ResultSet::Airport;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Schema::ResultSet);

=head2 searchAirportsOfDEparture(city => $city)

Получение списка аэропортов отправления в которых
  - установлене флаг доступности is_published=1

 Внутренний метод, используемыый в бекофисе программы
 при работе с нумерацией рейсов.

=cut

sub searchAirportsOfDeparture {
    my ($self, %params) = @_;

    return
        unless $params{'city'};

    return
        $self->result_source->resultset->search({
            'country.is_published' => 1,
            'city.is_published'    => 1,
            'me.is_published'      => 1,
            'me.city_id'           => $params{'city'}
        }, {
            where => [ -and => {
                'city.country_id'  => \'=country.id',
                'me.city_id'       => \'=city.id'
            }],
            from     => [ 'airport as me, city, country' ],
            group_by => 'me.id',
        });
}

1;
