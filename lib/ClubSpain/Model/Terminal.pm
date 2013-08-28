package ClubSpain::Model::Terminal;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Terminal' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'airport_id' => (
    is      => 'rw',
    reader  => 'get_airport_id',
    writer  => 'set_airport_id',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Terminal';

sub create {
    my $self = shift;
    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    return $self -> SUPER::update( $self -> params() );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Terminal

=head1 SYNOPSIS

    use ClubSpain::Model::Terminal;
    my $object = ClubSpain::Model::terminal  ->  new(
        id           => $id,
        airport_id   => $airport,
        name         => $name,
        is_published => $flag,
    );

    my $res = $object  ->  create();
    my $res = $object  ->  update();

=head1 DESCRIPTION

Терминал

=head1 FIELDS

=head2 id

Идентификатор терминала

=head2 airport_id

Идентификатор аэропорта

=head2 name

Название терминала

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Добавление записи в бузу данных.

=head2 update()

Обновление записи в базе данных.

=head1 SEE ALSO

L<ClubSpain::Model::Role::Terminal>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut