package ClubSpain::Test;

use strict;
use warnings;

BEGIN {
    use base qw(Test::Builder::Module);

    use Test::More;

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
        [qw(country_id name is_published)],
        [$country[0]->id, 'Moscow', 1],
        [$country[1]->id, 'Barcelona', 1],
        [$country[1]->id, 'Malaga', 1],
        [$country[2]->id, 'Andorra la Vella', 1]
    ]);

    my @airport = $schema->populate('Airport', [
        [qw(city_id iata icao name is_published)],
        [$city[0]->id, 'DME', 'UUDD', 'Domodedovo', 1],
        [$city[0]->id, 'VKO', 'UUWW', 'Vnukovo', 1],
        [$city[0]->id, 'SVO', 'UUEE', 'Sheremetyevo', 1],
        [$city[1]->id, 'BCN', 'LEBL', 'El Prat', 1],
        [$city[2]->id, 'AGP', 'LEMG', 'Malaga airport', 1]
    ]);

    my @article = $schema->populate('Article', [
        [qw(parent_id weight is_published header subheader body)],
        [0, 1, 0, 'HEADER1', 'SUBHEADER1', 'BODY1'],
        [0, 5, 1, 'HEADER2', 'SUBHEADER2', 'BODY2']
    ]);

    my @manufacturer = $schema->populate('Manufacturer', [
        [qw(code name)],
        ['SUKHOI', 'Gosudarstvennoye Unitarnoye Predpriyatie Aviatsionnyi Voyenno-Promyshlennyi Komplex Sukhoi'],
        ['AIRBUS', 'Airbus SAS'],
        ['BOEING', 'Boeing Aircraft Company'],
        ['SAAB',   'Saab AB']
    ]);

    my @airline = $schema->populate('Airline', [
        [qw(iata icao name is_published)],
        ['NN', 'MOV', 'VIM Airlines', 1],
        ['UN', 'TSO', 'Transare Airlines', 1],
        ['IB', 'IBE', 'Iberia Airlines', 1]
    ]);
}

sub clear_schema {
    my ($self, $schema) = @_;

    foreach my $source ($schema->sources) {
        $schema->resultset($source)->delete_all;
    }
}


1;
