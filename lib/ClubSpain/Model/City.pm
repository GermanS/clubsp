package ClubSpain::Model::City;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'City' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'country_id' => (
    is      => 'rw',
    reader  => 'get_country_id',
    writer  => 'set_country_id',
);
has 'iata' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength3',
    reader  => 'get_iata',
    writer  => 'set_iata',
);
has 'name_en' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name_en',
    writer  => 'set_name_en',
);
has 'name_ru' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name_ru',
    writer  => 'set_name_ru',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::City';

sub validate_country_id {
    1;
}
sub validate_iata {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('iata')->type_constraint->validate($value);
}
sub validate_name_en {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name_en')->type_constraint->validate($value);
}
sub validate_name_ru {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name_ru')->type_constraint->validate($value);
}

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        country_id   => $self->get_country_id,
        iata         => $self->get_iata,
        name         => $self->get_name_en,
        name_ru      => $self->get_name_ru,
        is_published => $self->get_is_published,
    };
}

sub searchCitiesOfDeparture {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchCitiesOfDeparture(%params);
}

sub searchCitiesOfDepartureInFlight {
    my $self = shift;

    return
        $self->schema()
             ->resultset('ViewFlight')
             ->searchCitiesOfDeparture();
}

sub searchCitiesOfArrivalInFlight {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewFlight')
             ->searchCitiesOfArrival(%params);
}

sub searchCitiesOfDepartureOW {
    my $self = shift;

    return
        $self->schema()
             ->resultset('ViewItineraryOW')
             ->searchCitiesOfDeparture();
}

sub searchCitiesOfArrivalOW {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryOW')
             ->searchCitiesOfArrival(%params);
}

=head2 searchCitiesOfDeparture1RT(%params)

Поиск городов отправления в тарифах в обе стороны
На входе
  cityOfDeparture1 - первый город отправления

На выходе
   Города прибытия.

=cut

sub searchCitiesOfDeparture1RT {
    my $self = shift;

    return
        $self->schema()
             ->resultset('ViewItineraryRT')
             ->searchCitiesOfDeparture1();
}

=head2 searchCitiesOfArrival1RT(%params)

Поиск городов прибытия в тарифах в обе стороны
по указанному городу отправления
На входе
  cityOfDeparture1 - первый город отправления

На выходе
   Города прибытия.

=cut

sub searchCitiesOfArrival1RT {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryRT')
             ->searchCitiesOfArrival1(%params);
}

=head2 searchCitiesOfDeparture2RT(%params)

Поиск городов отправления в тарифах в обе стороны
по указанным городам отправления и прибытия
На входе
  cityOfDeparture1 - первый город отправления
  cityOfArrival1   - первый город прибытия

На выходе
   Города отправления.

=cut

sub searchCitiesOfDeparture2RT {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryRT')
             ->searchCitiesOfDeparture2(%params);
}

=head2 searchCitiesOfArrival2RT(%params)

Поиск городов прибытия в тарифах в обе стороны
по указанным городам отправления и прыбытия первого сегмента \
и городу отправления второго
На входе
  cityOfDeparture1 - первый город отправления
  cityOfArrival1   - первый город прибытия
  cityOfDeparture2 - второй город отправления

На выходе
   Города прилета.

=cut

sub searchCitiesOfArrival2RT {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryRT')
             ->searchCitiesOfArrival2(%params);
}

=head2 suggest($string);

Поиск города по начальным буквам.
Количество букв в строке должно быть не менее 3х.
На входе:
  $string - строка для поиска города

=cut

sub suggest {
    my ($self, $string) = @_;

    $string ||= '';
    my $result;
    return $result if length($string) < 3;

    if ( $string =~ m/^([a-z]*)$/i ) {
        if (length $string == 3) {
            $result =$self->_search_by_iata($string);
        }

        unless ($result && ( $result->can('count') && $result->count() )) {
            $result = $self->_search_like_by_name($string);
        }
    } elsif ( $string =~ m/^([а-я])*$/i ) {
        $result = $self->_search_like_by_name_ru($string);
    }

    return $result
}

sub _search_like_by_name {
    my ($self, $string) = @_;

    return $self->search({ name => \"LIKE '$string%'"}, {});
}

sub _search_like_by_name_ru {
    my ($self, $string) = @_;

    return $self->search({ name_ru => \"LIKE '$string%'"}, {});
}

sub _search_by_iata {
    my ($self, $iata) = @_;

    return $self->search({ iata => $iata }, {});
}

__PACKAGE__->meta->make_immutable();

1;
