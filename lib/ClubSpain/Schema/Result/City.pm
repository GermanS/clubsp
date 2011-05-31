package ClubSpain::Schema::Result::City;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::Result);


__PACKAGE__->load_components(qw(Core PK::Auto));
__PACKAGE__->table('city');
__PACKAGE__->source_name('City');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    country_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    iata => {
        data_type     => 'char',
        size          => 3,
        is_nullable   => 0,
    },
    name => {
        data_type     => 'char',
        size          => 254,
        is_nullable   => 0
    },
    is_published => {
        data_type     => 'tinyint unsigned',
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(on_iata => [qw(iata)]);
__PACKAGE__->add_unique_constraint(on_country_id_name => [qw(country_id name)]);


__PACKAGE__->belongs_to(
    'country' => 'ClubSpain::Schema::Result::Country', 'country_id'
);
__PACKAGE__->has_many(
    airports => 'ClubSpain::Schema::Result::Airport',
    { 'foreign.city_id' => 'self.id' },
    { cascade_delete => 0 }
);


=head2 searchCitiesOfDeparture()

Получение списка городов отправления в которых
 - есть аэропорты
 - установлене флаг доступности is_published=1

=cut

sub searchCitiesOfDeparture {
    my $self = shift;
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
