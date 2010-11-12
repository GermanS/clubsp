package ClubSpain::Design::Article;

use Moose;
use namespace::autoclean;

use base qw(ClubSpain::Design::Base);

has 'id'            => ( is => 'ro' );
has 'parent_id'     => ( is => 'ro', required => 1 );
has 'weight'        => ( is => 'ro', required => 1 );
has 'is_published'  => ( is => 'ro', required => 1 );
has 'header'        => ( is => 'ro', required => 1 );
has 'body'          => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->schema->resultset('Article')->create({
        parent_id => $self->parent_id,
        weight => $self->weight,
        is_published => $self->is_published,
        header => $self->header,
        body => $self->body,
    });
}

__PACKAGE__->meta->make_immutable();

1;
