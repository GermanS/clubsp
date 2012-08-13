package ClubSpain::Test;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose;

use DateTime;
use FileHandle;
use Test::More;
@ClubSpain::Test::EXPORT = @Test::More::EXPORT;

# схема
has 'schema'      => ( is => 'rw' );
# 1 удалить содержимое всех таблиц, по умолчанию 0 - не удалять
has 'clear'       => ( is => 'rw', default => sub { 0 } );
# 1 не перезаписывать схему заново, по умолчанию 0 - перезаписать
has 'no_deploy'   => ( is => 'rw', default => sub { 0 } );
# 1 не заполнять тестовыми данными, по умолчанию 0 - заполнять
has 'no_populate' => ( is => 'rw', default => sub { 0 } );

sub BUILD {
    my $self = shift;

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

    my $schema = $config->{'Model::DBIC::Schema'}->{'schema_class'}->connect(
         $config->{'Model::DBIC::Schema'}{'connect_info'}{'dsn'},
         $config->{'Model::DBIC::Schema'}{'connect_info'}{'user'},
         $config->{'Model::DBIC::Schema'}{'connect_info'}{'password'},
         {
             mysql_enable_utf8 =>$config->{'Model::DBIC::Schema'}{'connect_info'}{'mysql_enable_utf8'}
         },
    );

    $self->schema($schema);

    $self->deploy_schema()
        unless $self->no_deploy;
    $self->populate_schema()
        unless $self->no_populate;
};

sub deploy_schema {
    my $self = shift;

    my $schema = $self->schema();
    eval 'use SQL::Translator';
    if (!$@) {
        eval { $schema->deploy( {add_drop_table => 1 }); };
        die $@ if $@;
    } else {
        die("Could not load SQL::Translator: $@");
    }
};

sub populate_schema {
    my ($self, %args) = @_;

    my $schema = $self->schema();
    $self->clear_schema()
        if $self->clear;


    my @country = $schema->populate('Country',[
        [qw(name alpha2 alpha3 numerics is_published)],
        [qw(Russia ru rus 007 1)],
        [qw(Spain es esp 034 1)],
        [qw(Andorra an and 036 1)]
    ]);

    my @city = $schema->populate('City', [
        [qw(country_id iata name name_ru is_published)],
        [$country[0]->id, 'MOW', 'Moscow', 'Москва', 1],
        [$country[1]->id, 'BCN', 'Barcelona', 'Барселона', 1],
        [$country[1]->id, 'AGP', 'Malaga', 'Малага', 1],
        [$country[2]->id, 'xxx', 'Andorra la Vella', 'Андорра ла Велла', 1]
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
        [qw(timetable_id is_published fare_class_id parent_id cost)],
        [$timetable[6]->id,  1, $fareclass[0]->id, 0, 175], #NN331 Y 175(eur) на будущую субботу ONE WAY
        [$timetable[6]->id,  1, $fareclass[1]->id, 0, 250], #NN331 C 250(eur) на будущую субботу ONE WAY
        [$timetable[9]->id,  1, $fareclass[0]->id, 0, 200], #NN332 Y 200(eur) на будущую субботу ONE WAY
        [$timetable[9]->id,  1, $fareclass[1]->id, 0, 350], #NN332 C 350(eur) на будущую субботу ONE WAY

        [$timetable[6]->id,  1, $fareclass[0]->id, 0, 150], #NN331 Y 150(eur) вылет будущей субботой
        [$timetable[10]->id, 1, $fareclass[0]->id, 5, 160], #NN332 Y 160(eur) возвлат через неделю

        [$timetable[6]->id,  1, $fareclass[0]->id, 0, 170], #NN331 Y 170 вылет в будущую субботу
        [$timetable[11]->id, 1, $fareclass[0]->id, 7, 170], #NN332 Y 170 возврат через 2 недели

        [$timetable[6]->id,  1, $fareclass[1]->id, 0, 250], #NN331 C 250(eur) вылет будущей субботой
        [$timetable[10]->id, 1, $fareclass[1]->id, 9, 350], #NN332 C 350(eur) возвлат через неделю
    ]);

    my @employee = $schema->populate('Employee', [
        [qw(name surname email password is_published)],
        ['name', 'surname', 'name@mail.com', 123, 1]
    ]);
}

sub clear_schema {
    my $self = shift;

    my $schema = $self->schema();
    foreach my $source ($schema->sources) {
        $schema->resultset($source)->delete_all;
    }
};

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
};

sub comp_to_file {
    my ($class, $string, $file) = @_;

    return 0 unless $string && $file && -e $file && -r $file;

    $string =~ s/\n//g;
    $string =~ s/\s//g;
    $string =~ s/\t//g;

    my $fh = FileHandle->new("<$file");
    if (defined $fh) {
        local $/ = undef;
        my $contents = <$fh>;
        $contents =~ s/\n//g;
        $contents =~ s/\s//g;
        $contents =~ s/\t//g;

        # remove the tt2 and xml Ids
        $contents =~ s/<!--.*-->//;
        $contents =~ s/\[%#.*%\]//;

        undef $fh;

        if ($string eq $contents) {
            return (1, $string, $contents);
        } else {
            return (0, $string, $contents);
        };
    };

    return 0;
};

#страна россия
sub russia {
    return shift->schema->resultset('Country')->search({ id => 1 })->single();
};

#город москва
sub moscow {
    return shift->schema->resultset('City')->search({ id => 1 })->single();
};

#аэропорт домодедово
sub dme {
    return shift->schema->resultset('Airport')->search({ id => 1 })->single();
}
#страна испания
sub spain {
    return shift->schema->resultset('Country')->search({ id => 2 })->single();
};

#город барселона
sub barcelona {
    return shift->schema->resultset('City')->search({ id => 2 })->single();
};

#аэропорт барселоны
sub bcn {
    return shift->schema->resultset('Airport')->search({ id => 4 })->single();
};

#авиакомпания Вим-Авиа
sub NN {
    return shift->schema->resultset('Airline')->search({ id => 1 })->single();
};

#эконом класс
sub Y {
    return shift->schema->resultset('FareClass')->search({ id => 1 })->single;
};

#бизнес класс
sub C {
    return shift->schema->resultset('FareClass')->search({ id => 2 })->single;
};

#OW MOW->BCN Y
sub MOW_BCN_Y_OW {
    return shift->schema->resultset('Itinerary')->search({ id => 1 })->single;
}

#MOW->BCN->MOW Y NN331/332 1 week
sub MOW_BCN_MOW_Y_NN331_NN332 {
    my $self = shift;

    my @date = $self->three_saturdays_ahead();
    my $MOW = $self->moscow();
    my $BCN = $self->barcelona();

    return $self->schema->resultset('Itinerary')->itineraries({
            cityOfDeparture => $MOW->id,
            cityOfArrival   => $BCN->id,
            dateOfDeparture => $date[0]->ymd,
            asObject        => 1
        }, {
            cityOfDeparture => $BCN->id,
            cityOfArrival   => $MOW->id,
            dateOfDeparture => $date[1]->ymd,
    })->first();
}

__PACKAGE__->meta->make_immutable();

1;
