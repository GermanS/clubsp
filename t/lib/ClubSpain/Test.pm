package ClubSpain::Test;

use strict;
use warnings;

BEGIN {
    use base qw(Test::Builder::Module);

    use Test::More;
    use DateTime;

    @ClubSpain::Test::EXPORT = @Test::More::EXPORT;
};

sub init_schema {
    my ($self, %args) = @_;

    eval 'use DBD::mysql';
    if ($@) {
        BAIL_OUT("DBD::mysql not installed");
        return;
    }

    eval 'use ClubSpain::Schema';
    if ($@) {
        BAIL_OUT("Could not load ClubSpain::Schema: $@");
        return;
    }

    eval 'use Config::Any';
    if ($@) {
        BAIL_OUT("Could not load Config::Any: $@");
        return;
    }

    my $file = 'clubspain.conf';
    my $config = eval {
        Config::Any->load_files({
            files   => [$file],
            use_ext => 1
        })->[0]->{$file}
    };
    if ($@) {
        BAIL_OUT("Could not load clubspain.conf configuration file: $@");
        return;
    }

    my $schema = ClubSpain::Schema->connect(
        $config->{'Model::DBIC'}{'connect_info'}{'dsn'},
        $config->{'Model::DBIC'}{'connect_info'}{'user'},
        $config->{'Model::DBIC'}{'connect_info'}{'password'},
    );

    $self->deploy_schema($schema, %args)
        unless $args{'no_deploy'};
    $self->populate_schema($schema, %args)
        unless $args{'no_populate'};

    return $schema;
}

sub deploy_schema {
    my ($self, $schema) = @_;

    eval 'use SQL::Translator';
    if (!$@) {
        eval { $schema->deploy( {add_drop_table => 1 }); };
        die $@ if $@;
    } else {
        die("Could not load SQL::Translator: $@");
    }
}

sub populate_schema {
    my ($self, $schema, %args) = @_;

    $self->clear_schema($schema)
        if $args{'clear'};


    my @country = $schema->populate('Country',[
        [qw(name alpha2 alpha3 numerics is_published)],
        [qw(Russia ru rus 007 1)],
        [qw(Spain es esp 034 1)],
        [qw(Andorra an and 036 1)]
    ]);

    my @city = $schema->populate('City', [
        [qw(country_id iata name is_published)],
        [$country[0]->id, 'MOW', 'Moscow', 1],
        [$country[1]->id, 'BCN', 'Barcelona', 1],
        [$country[1]->id, 'AGP', 'Malaga', 1],
        [$country[2]->id, 'xxx', 'Andorra la Vella', 1]
    ]);

    my @airport = $schema->populate('Airport', [
        [qw(city_id iata icao name is_published)],
        [$city[0]->id, 'DME', 'UUDD', 'Domodedovo', 1],
        [$city[0]->id, 'VKO', 'UUWW', 'Vnukovo', 1],
        [$city[0]->id, 'SVO', 'UUEE', 'Sheremetyevo', 1],
        [$city[1]->id, 'BCN', 'LEBL', 'El Prat', 1],
        [$city[2]->id, 'AGP', 'LEMG', 'Malaga airport', 1]
    ]);

    my @terminal = $schema->populate('Terminal', [
        [qw(airport_id name is_published)],
        [$airport[2]->id, 'Terminal B', 1],
        [$airport[2]->id, 'Terminal C', 1],
        [$airport[2]->id, 'Terminal F', 1],
    ]);

    my @article = $schema->populate('Article', [
        [qw(parent_id weight is_published header subheader body)],
        [0, 1, 0, 'HEADER1', 'SUBHEADER1', 'BODY1'],
        [0, 5, 1, 'HEADER2', 'SUBHEADER2', 'BODY2']
    ]);

    my @airline = $schema->populate('Airline', [
        [qw(iata icao name is_published)],
        ['NN', 'MOV', 'VIM Airlines', 1],
        ['UN', 'TSO', 'Transaro Airlines', 1],
        ['IB', 'IBE', 'Iberia Airlines', 1]
    ]);

    my @manufacturer = $schema->populate('Manufacturer', [
        [qw(code name)],
        ['SUKHOI', 'Gosudarstvennoye Unitarnoye Predpriyatie Aviatsionnyi Voyenno-Promyshlennyi Komplex Sukhoi'],
        ['AIRBUS', 'Airbus SAS'],
        ['BOEING', 'Boeing Aircraft Company'],
        ['SAAB',   'Saab AB']
    ]);

    my @airplane = $schema->populate('Airplane', [
        [qw(manufacturer_id iata icao name is_published)],
        [$manufacturer[1]->id, '318', 'A318', 'A318', 1],
        [$manufacturer[1]->id, '319', 'A319', 'A319', 1],
        [$manufacturer[2]->id, '757-200 ', '752', 'B752', 1],
    ]);

    my @flight = $schema->populate('Flight', [
        [qw(is_published departure_airport_id destination_airport_id airline_id code)],
        [1, $airport[0]->id, $airport[3]->id, $airline[0]->id, 331], #NN331 DME -> BCN
        [1, $airport[3]->id, $airport[0]->id, $airline[0]->id, 332], #NN332 BCN -> DME
        [1, $airport[2]->id, $airport[4]->id, $airline[2]->id, 989], #IB989 SVO -> AGP
        [1, $airport[4]->id, $airport[2]->id, $airline[2]->id, 990], #IB990 AGP -> 989
    ]);

    my @plan = $self->three_saturdays_ahead();

    my @timetable = $schema->populate('TimeTable', [
        [qw(is_published
            flight_id
            airplane_id
            departure_date
            departure_time
            arrival_date
            arrival_time
            departure_terminal_id
            arrival_terminal_id)],
       [1, $flight[0]->id, $airplane[2]->id, '2011-02-12', '10:00', '2011-02-12', '16:00', undef, undef], #NN331 DME->BCN
       [1, $flight[0]->id, $airplane[2]->id, '2011-02-19', '06:00', '2011-02-19', '08:00', undef, undef], #NN331 DME->BCN
       [1, $flight[0]->id, $airplane[2]->id, '2011-02-26', '06:00', '2011-02-26', '08:00', undef, undef], #NN331 DME->BCN
       [1, $flight[1]->id, $airplane[2]->id, '2011-02-12', '10:00', '2011-02-12', '16:00', undef, undef], #NN332 BCN->DME
       [1, $flight[1]->id, $airplane[2]->id, '2011-02-19', '10:00', '2011-02-19', '16:00', undef, undef], #NN332 BCN->DME
       [1, $flight[1]->id, $airplane[2]->id, '2011-02-26', '10:00', '2011-02-26', '16:00', undef, undef], #NN332 BCN->DME
       [1, $flight[0]->id, $airplane[2]->id, $plan[0]->ymd,'10:00', $plan[0]->ymd,'12:00', undef, undef], #NN331 DME->BCN
       [1, $flight[0]->id, $airplane[2]->id, $plan[1]->ymd,'10:00', $plan[1]->ymd,'12:00', undef, undef], #NN331 DME->BCN
       [1, $flight[0]->id, $airplane[2]->id, $plan[2]->ymd,'10:00', $plan[2]->ymd,'12:00', undef, undef], #NN331 DME->BCN
       [1, $flight[1]->id, $airplane[2]->id, $plan[0]->ymd,'14:00', $plan[0]->ymd,'20:00', undef, undef], #NN332 BCN->DME
       [1, $flight[1]->id, $airplane[2]->id, $plan[1]->ymd,'14:00', $plan[1]->ymd,'20:00', undef, undef], #NN332 BCN->DME
       [1, $flight[1]->id, $airplane[2]->id, $plan[2]->ymd,'14:00', $plan[2]->ymd,'20:00', undef, undef], #NN332 BCN->DME
    ]);

    my @fareclass = $schema->populate('FareClass', [
        [qw(code name is_published)],
        ['Y', 'Economy', 1],
        ['C', 'Business', 1],
    ]);

    my @itinerary = $schema->populate('Itinerary', [
        [qw(timetable_id fare_class_id parent_id cost)],
        [$timetable[6]->id, $fareclass[0]->id, 0, 175], #NN331 Y 175(eur) на будущую субботу ONE WAY
        [$timetable[6]->id, $fareclass[1]->id, 0, 250], #NN331 C 250(eur) на будущую субботу ONE WAY
        [$timetable[9]->id, $fareclass[0]->id, 0, 200], #NN332 Y 200(eur) на будущую субботу ONE WAY
        [$timetable[9]->id, $fareclass[1]->id, 0, 350], #NN332 C 350(eur) на будущую субботу ONE WAY

        [$timetable[6]->id,  $fareclass[0]->id, 0, 150], #NN331 Y 150(eur) вылет будущей субботой
        [$timetable[10]->id, $fareclass[0]->id, 5, 160], #NN332 Y 160(eur) возвлат через неделю

        [$timetable[6]->id,  $fareclass[0]->id, 0, 170], #NN331 Y 170 вылет в будущую субботу
        [$timetable[11]->id, $fareclass[0]->id, 7, 170], #NN332 Y 170 возврат через 2 недели

        [$timetable[6]->id,  $fareclass[1]->id, 0, 250], #NN331 C 250(eur) вылет будущей субботой
        [$timetable[10]->id, $fareclass[1]->id, 9, 350], #NN332 C 350(eur) возвлат через неделю
    ]);
}

sub clear_schema {
    my ($self, $schema) = @_;

    foreach my $source ($schema->sources) {
        $schema->resultset($source)->delete_all;
    }
}

#plan saturday flights
sub three_saturdays_ahead {
    my $self = shift;

    my $now  = DateTime->now();
    my $start = ($now->day_of_week < 6)
        ? $now + DateTime::Duration->new(days => 6 - $now->day_of_week)
        : $now + DateTime::Duration->new(days => 6 - $now->day_of_week, weeks => 1);

    my $week = DateTime::Duration->new(weeks => 1);
    return ($start,
            $start + $week,
            $start + $week + $week);
}

1;
