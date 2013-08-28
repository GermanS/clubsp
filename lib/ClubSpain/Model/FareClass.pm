package ClubSpain::Model::FareClass;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'FareClass' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'code' => (
    is      => 'rw',
    isa     => 'AlphaLength1',
    reader  => 'get_code',
    writer  => 'set_code',
);
has 'name' => (
    is      => 'rw',
    reader  => 'get_name',
    writer  => 'set_name',
    isa     => 'StringLength2to255'
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::FareClass';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

__PACKAGE__ -> meta -> make_immutable;

1;

__END__

=head1 NAME

ClubSpian::Model::FareClass

=head1 SYNOPSIS

    use ClubSpian::Model::FareClass;
    my $object = ClubSpian::Model::FareClass -> new(
        id           => $id,
        name         => $name,
        code         => $code,
        is_published => $flag,
    );

    my $res = $object -> create();
    my $res = $object -> update();

=head1 DESCRIPTION

Класс обслуживания

=head1 FIELDS

=head2 id

Идентификатор класса обслуживания

=head2 code

Код класса обслуживания

=head2 name

Название класса обслуживания

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание записи в базе данных

=head2 update()

Редактирование записи в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::FareClass>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut