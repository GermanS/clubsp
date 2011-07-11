package ClubSpain::Schema::ResultSet::Country;
use strict;
use warnings;
use utf8;
use parent qw(DBIx::Class::ResultSet);

=head2

Получение списка стран отправления, в которых:
 - есть города с аэропортами
 - установлене флаг доступности is_published=1

 Внутренний метод, используемыый в бекофисе программы.

=cut

sub searchCountriesOfDeparture {
    my $self = shift;

    return
        $self->result_source->resultset->search({
            'me.is_published'      => 1,
            'city.is_published'    => 1,
            'airport.is_published' => 1,
        }, {
            where  => [ -and => {
                'city.country_id ' => \'=me.id',
                'airport.city_id'  => \'=city.id'
            }],
            from     => [ 'country as me, city, airport' ],
            group_by => 'me.id'
        });
}

1;
