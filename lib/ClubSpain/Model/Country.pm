package ClubSpain::Model::Country;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Country' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'alpha2' => (
    is      => 'rw',
    isa     => 'AlphaLength2',
    reader  => 'get_alpha2',
    writer  => 'set_alpha2',
);
has 'alpha3' => (
    is      => 'rw',
    isa     => 'AlphaLength3',
    reader  => 'get_alpha3',
    writer  => 'set_alpha3',
);
has 'numerics' => (
    is      => 'rw',
    isa     => 'NaturalLessThan1000',
    reader  => 'get_numerics',
    writer  => 'set_numerics',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Country';

sub validate_name {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}
sub validate_alpha2 {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('alpha2')->type_constraint->validate($value);
}
sub validate_alpha3 {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('alpha3')->type_constraint->validate($value);
}
sub validate_numerics {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('numerics')->type_constraint->validate($value);
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

    return  {
        name         => $self->get_name,
        alpha2       => $self->get_alpha2,
        alpha3       => $self->get_alpha3,
        numerics     => $self->get_numerics,
        is_published => $self->get_is_published,
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


