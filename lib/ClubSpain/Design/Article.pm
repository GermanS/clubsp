package ClubSpain::Design::Article;

use Moose;
use namespace::autoclean;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);

use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'parent_id'     => ( is => 'ro', required => 1 );
has 'weight'        => ( is => 'ro', required => 1, default => 0 );
has 'is_published'  => ( is => 'ro', required => 1 );
has 'header'        => ( is => 'ro', required => 1 );
has 'body'          => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    my $weight = $self->list($self->parent_id)->count();

    $self->schema->resultset('Article')->create({
        parent_id   => $self->parent_id,
        weight      => $weight,
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

sub list {
    my $self = shift;
    my $parent = shift || 0;

    my $iterator = $self->schema
                        ->resultset('Article')
                        ->search({
                            parent_id => $parent
                        }, {
                            order_by => 'weight'
                        });

    return $iterator;
}

sub move_up {
    my ($class, $article) = @_;

    my $weight = 1;
    my $previous;
    my $iterator = $class->list($article->parent_id);
    while (my $story = $iterator->next) {
        $story->update({ weight => $weight });

        if ($story->id == $article->id && $previous) {
            my $weight_prev = $previous->weight();

            $previous->update({ weight => $weight });
            $story->update({ weight => $weight_prev })
        }

        $weight++;
        $previous = $story;
    }
}

sub move_down {
    my ($class, $article) = @_;

    my $previous;
    my $iterator = $class->list($article->parent_id);
    while (my $story = $iterator->next()) {
        if ($previous && $previous->id == $article->id) {
            $class->move_up($story);
            last;
        }

        $previous = $story;
    }

}

__PACKAGE__->meta->make_immutable();

1;
