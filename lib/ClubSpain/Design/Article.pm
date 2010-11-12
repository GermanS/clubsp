package ClubSpain::Design::Article;

use Moose;
use namespace::autoclean;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);

use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'parent_id'     => ( is => 'ro', required => 1 );
has 'weight'        => ( is => 'ro', required => 1 );
has 'is_published'  => ( is => 'ro', required => 1 );
has 'header'        => ( is => 'ro', required => 1 );
has 'body'          => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->schema->resultset('Article')->create({
        parent_id   => $self->parent_id,
        weight      => $self->weight,
        is_published => $self->is_published,
        header      => $self->header,
        body        => $self->body,
    });
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update({
        parent_id   => $self->parent_id,
        weight      => $self->weight,
        is_published => $self->is_published,
        header      => $self->header,
        body        => $self->body,
    });
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset('Article')
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find Article: $id!")
        unless $object;

    return $object;
}

__PACKAGE__->meta->make_immutable();

1;
