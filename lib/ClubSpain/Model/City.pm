package ClubSpain::Model::City;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'City' });

has 'id'            => ( is => 'ro' );
has 'country_id'    => ( is => 'ro', required => 1 );
has 'iata'          => ( is => 'ro', required => 1, isa => 'AlphaNumericLength3' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'name_ru'       => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );

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
        country_id   => $self->country_id,
        iata         => $self->iata,
        name         => $self->name,
        name_ru      => $self->name_ru,
        is_published => $self->is_published,
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
