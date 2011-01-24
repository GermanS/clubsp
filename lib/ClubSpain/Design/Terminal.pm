package ClubSpain::Design::Terminal;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'airport_id'    => ( is => 'ro', required => 1 );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );


sub create {
    my $self = shift;

    $self->schema->resultset('Terminal')->create({
        airport_id   => $self->airport_id,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('Terminal')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Terminal: $id!")
        unless $object;

    return $object;
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        airport_id   => $self->airport_id,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub list {
    my $self = shift;

    my $iterator = $self->schema
                        ->resultset('Terminal')
                        ->search({}, { order_by => 'id' });

    return $iterator;
}

1;
