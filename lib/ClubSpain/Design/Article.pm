package ClubSpain::Design::Article;

use Moose;
use namespace::autoclean;
use utf8;

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

    #проверка, что нельзя устанавливать себя как потомка
    throw ClubSpain::Exception::Argument(message => 'NOT_ALLOWED')
        if $self->id == $self->parent_id;

    my @options = $self->select_options($self->id);
    foreach my $option (@options) {
        throw ClubSpain::Exception::Argument(message => 'NOT_ALLOWED')
            if $option->{'value'} == $self->parent_id();
    }

    return $self->fetch_by_id()->update({
        parent_id   => $self->parent_id,
        weight      => $self->weight,
        is_published => $self->is_published,
        header      => $self->header,
        body        => $self->body,
    });
}

sub delete {
    my ($class, $id) = @_;

    throw ClubSpain::Exception::Argument(message => 'DELETE_NOT_ALLOWED_BECAUSE_OF_CHILD')
        if $class->list($id)->count();

    $class->SUPER::delete($id);
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

sub select_options {
    my $class  = shift;
    my $parent = shift || 0;
    my $level  = shift || 0;

    my @values = ();

    my $iterator = $class->list($parent);
    while (my $story = $iterator->next()) {
        push @values, {
            value => $story->id,
            label => sprintf "%s %s", '--' x $level, $story->header
        };
        push @values, $class->select_options($story->id, $level+1);
    }

    return @values;
}

__PACKAGE__->meta->make_immutable();

1;
