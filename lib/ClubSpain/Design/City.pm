package ClubSpain::Design::City;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Common qw(minify);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'country_id'    => ( is => 'ro', required => 1 );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );



sub BUILDARGS {
    my ($class,  %param) = @_;

    $param{'name'} = minify($param{'name'});

    return \%param;
}

sub create {
    my $self = shift;

    $self->schema->resultset('City')->create({
        country_id   => $self->country_id,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('City')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find City: $id!")
        unless $object;

    return $object;
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        country_id   => $self->country_id,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub list {
    my ($class, $params) = @_;
    return unless $params;

    my $iterator = $class->schema
                        ->resultset('City')
                        ->search($params);

    return $iterator;
}

1;
