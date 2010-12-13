package ClubSpain::Design::Country;

use Moose;
use namespace::autoclean;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);

use ClubSpain::Common qw(minify);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'alpha2'        => ( is => 'ro', required => 1, isa => 'AlphaLength2' );
has 'alpha3'        => ( is => 'ro', required => 1, isa => 'AlphaLength3' );
has 'numerics'      => ( is => 'ro', required => 1, isa => 'NaturalLessThan1000' );
has 'is_published'  => ( is => 'ro', required => 1 );

sub BUILDARGS {
    my ($class,  %param) = @_;

    $param{'name'} = minify($param{'name'});

    return \%param;
}

sub create {
    my $self = shift;

    $self->schema->resultset('Country')->create({
        name         => $self->name,
        alpha2       => $self->alpha2,
        alpha3       => $self->alpha3,
        numerics     => $self->numerics,
        is_published => $self->is_published,
    });
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        name         => $self->name,
        alpha2       => $self->alpha2,
        alpha3       => $self->alpha3,
        numerics     => $self->numerics,
        is_published => $self->is_published,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('Country')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Country: $id!")
        unless $object;

    return $object;
}

sub list {
    my $self = shift;

    my $iterator = $self->schema
                        ->resultset('Country')
                        ->search({}, { order_by => 'id' });

    return $iterator;
}

sub delete {
    my ($class, $id) = @_;

    $class->SUPER::delete($id);
}


__PACKAGE__->meta->make_immutable();

1;


