package ClubSpain::Model::Article;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use Scalar::Util qw(blessed);
use ClubSpain::Exception;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Article' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'parent_id' => (
    is      => 'rw',
    default => sub { 0 },
    reader  => 'get_parent_id',
    writer  => 'set_parent_id',
);
has 'weight' => (
    is      => 'rw',
    default => sub { 0 },
    reader  => 'get_weight',
    writer  => 'set_weight',
);
has 'header' => (
    is      => 'rw',
    reader  => 'get_header',
    writer  => 'set_header',
);
has 'subheader' => (
    is => 'rw',
    reader => 'get_subheader',
    writer => 'set_subheader',
);
has 'body' => (
    is      => 'rw',
    reader  => 'get_body',
    writer  => 'set_body',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Article';

sub validate_parent_id { 1; }
sub validate_header    { 1; }
sub validate_subheader { 1; }
sub validate_body      { 1; }

sub params {
    my $self = shift;

    return {
        parent_id   => $self->get_parent_id,
        weight      => $self->get_weight,
        header      => $self->get_header,
        subheader   => $self->get_subheader,
        body        => $self->get_body,
        is_published => $self->get_is_published,
    };
}

sub create {
    my $self = shift;

    my $weight = $self->list($self->get_parent_id)->count();
    $self->set_weight($weight);

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    #проверка, что нельзя устанавливать себя как потомка
    throw ClubSpain::Exception::Argument(message => 'NOT_ALLOWED')
        if $self->get_id == $self->get_parent_id;

    my @options = $self->select_options($self->get_id);
    foreach my $option (@options) {
        throw ClubSpain::Exception::Argument(message => 'NOT_ALLOWED')
            if $option->{'value'} == $self->get_parent_id();
    }

    $self->SUPER::update( $self->params() );
}

sub delete {
    my ($class, $id) = @_;

    throw ClubSpain::Exception::Argument(message => 'DELETE_NOT_ALLOWED_BECAUSE_OF_CHILD')
        if $class->list($id)->count();

    $class->SUPER::delete($id);
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

sub find_top_parent {
    my ($class, $article) = @_;

    return $article
        unless $article->parent_id;

    $class->find_top_parent($class->fetch_by_id($article->get_parent_id));
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

sub tree {
    my $class = shift;
    my $parent = shift || 0;

    my @values = ();
    my $iterator = $class->list($parent);
    while (my $child = $iterator->next) {
        push @values, {
            value => $child->id,
            label => $child->header,
            children => $class->tree($child->id)
        }
    }

    return \@values;
}

sub select_options {
    my ($class, $parent) = @_;

    my $tree = $class->tree($parent);
    return make_options($tree);

    sub make_options {
        my $tree = shift;
        my $level = shift || 0;
        my @options = ();

        foreach my $option (@$tree) {
            push @options, {
                value => $option->{'value'},
                label => sprintf "%s %s", '--' x $level, $option->{'label'},
            };

            push @options, make_options($option->{'children'}, $level+1);
        }

        return @options;
    }
}

__PACKAGE__->meta->make_immutable();

1;
