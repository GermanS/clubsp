package ClubSpain::Model::Country;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);

use ClubSpain::Types;
    with 'ClubSpain::Model::CountryRole';

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Country' });

has 'id'            => ( is => 'rw' );
has 'name'          => ( is => 'rw', required => 0, isa => 'StringLength2to255' );
has 'alpha2'        => ( is => 'rw', required => 0, isa => 'AlphaLength2' );
has 'alpha3'        => ( is => 'rw', required => 0, isa => 'AlphaLength3' );
has 'numerics'      => ( is => 'rw', required => 0, isa => 'NaturalLessThan1000' );
has 'is_published'  => ( is => 'rw', required => 0 );

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

    return  {
        name         => $self->name,
        alpha2       => $self->alpha2,
        alpha3       => $self->alpha3,
        numerics     => $self->numerics,
        is_published => $self->is_published,
    };
}

sub searchCountriesOfDeparture {
    my $self = shift;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchCountriesOfDeparture();
}

__PACKAGE__->meta->make_immutable();

1;


