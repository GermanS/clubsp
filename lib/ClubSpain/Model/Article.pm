package ClubSpain::Model::Article;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use Scalar::Util qw(blessed);
use ClubSpain::Exception;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Article' } );

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

sub create {
    my $self = shift;

    my $weight = $self -> list($self -> get_parent_id) -> count();
    $self -> set_weight($weight);

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    #проверка, что нельзя устанавливать себя как потомка
    throw ClubSpain::Exception::Argument(message => 'NOT_ALLOWED')
        if $self -> get_id == $self -> get_parent_id;

    my @options = $self -> select_options($self -> get_id);
    foreach my $option (@options) {
        throw ClubSpain::Exception::Argument(message => 'NOT_ALLOWED')
            if $option -> {'value'} == $self -> get_parent_id();
    }

    $self -> SUPER::update( $self -> params() );
}

sub delete {
    my ($class, $id) = @_;

    throw ClubSpain::Exception::Argument(message => 'DELETE_NOT_ALLOWED_BECAUSE_OF_CHILD')
        if $class -> list($id) -> count();

    $class -> SUPER::delete($id);
}

sub list {
    my $self = shift;
    my $parent = shift || 0;

    my $iterator = $self -> schema
                         -> resultset('Article')
                         -> search({
                            parent_id => $parent
                        }, {
                            order_by => 'weight'
                        });

    return $iterator;
}

sub find_top_parent {
    my ($class, $article) = @_;

    return $article
        unless $article -> parent_id;

    $class -> find_top_parent($class -> fetch_by_id($article -> get_parent_id));
}

sub move_up {
    my ($class, $article) = @_;

    my $weight = 1;
    my $previous;
    my $iterator = $class -> list($article -> parent_id);
    while (my $story = $iterator -> next) {
        $story -> update({ weight => $weight });

        if ($story -> id == $article -> id && $previous) {
            my $weight_prev = $previous -> weight();

            $previous -> update({ weight => $weight });
            $story -> update({ weight => $weight_prev })
        }

        $weight++;
        $previous = $story;
    }
}

sub move_down {
    my ($class, $article) = @_;

    my $previous;
    my $iterator = $class -> list($article -> parent_id);
    while (my $story = $iterator -> next()) {
        if ($previous && $previous -> id == $article -> id) {
            $class -> move_up($story);
            last;
        }

        $previous = $story;
    }
}

sub tree {
    my $class = shift;
    my $parent = shift || 0;

    my @values = ();
    my $iterator = $class -> list($parent);
    while (my $child = $iterator -> next) {
        push @values, {
            value => $child -> id,
            label => $child -> header,
            children => $class -> tree($child -> id)
        }
    }

    return \@values;
}

sub select_options {
    my ($class, $parent) = @_;

    my $tree = $class -> tree($parent);
    return make_options($tree);

    sub make_options {
        my $tree = shift;
        my $level = shift || 0;
        my @options = ();

        foreach my $option (@$tree) {
            push @options, {
                value => $option -> {'value'},
                label => sprintf "%s %s", '--' x $level, $option -> {'label'},
            };

            push @options, make_options($option -> {'children'}, $level+1);
        }

        return @options;
    }
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpian::Model::Article;

=head1 SYNOPSIS

    use ClubSpain::Model::Article;
    my $object = ClubSpain::Model::Article -> new(
        parent_id    => $parent_id,
        weight       => $weight,
        header       => $header,
        subheader    => $subheader,
        body         => $body,
        is_published => $is_published,
    );

    my $res     = $object -> create();
    my $res     = $object -> update();
    my $res     = $object -> delete();
    my @list    = $object -> list();
    my $parent  = $object -> find_top_parent();
    my $values  = $object -> tree();
    my @options = $object -> select_options();
    $object -> move_up();
    $object -> move_down();

=head1 DESCRIPTION

Статья на сайте

=head1 FIELDS

=head2 parent_id

Идентификатор родительской статьи

=head2 weight

Вес статьи. исполдьзуется для сортировки

=head2 header

Заголовок статьи

=head2 subheader

Подзаголовок статьи

=head2 body

Статья

=head2 is_published

Флаг опубликованности.

=head1 METHODS

=head2 create()

Добавление статьи в базу данных

=head2 update()

Обновление статьи в базе данных

=head2 delete()

Удаление статьи из базы данных

=head2 list()

Список статей

=head2 find_top_parent()

Найти статью верхнего уровня

=head2 tree()

Построение дерева статей

=head2 select_options()

Построение списка для popup элемента

=head2 move_up()

Уменьшение веса статьи

=head2 move_down()

Увеличение веса статьи

=head1 SEE ALSO

L<ClubSpain::Model::Role::Article>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut