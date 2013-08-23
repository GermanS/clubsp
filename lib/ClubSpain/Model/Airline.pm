package ClubSpain::Model::Airline;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airline' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'iata' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength2',
    reader  => 'get_iata',
    writer  => 'set_iata',
);
has 'icao' => (
    is      => 'rw',
    isa     => 'AlphaLength3',
    reader  => 'get_icao',
    writer  => 'set_icao',
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

with 'ClubSpain::Model::Role::Airline';


sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Airline

=head1 SYNOPSIS

    use ClubSpain::Model::Airline;
    my $object = ClubSpain::Model::Airline -> new(
        id           => $id,
        iata         => $iata
        icao         => $icao,
        is_published => $flag
    );

    if( $object -> validate_iata() ) { ... }
    if( $object -> validate_icao() ) { ... }
    if( $object -> validate_name() ) { ... }

    my $result = $object -> create();
    my $result = $object -> update();
    my $result = $object -> delete();

=head1 DESCRIPTION

Авиакомпания

=head1 FIELDS

=head2 id

Идентификатор авиакомпании

=head2 iata

IATA код авиакомпании

=head2 icao

ICAO код авиакомпании

=head2 name

Название авиакомпании

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Создание объекта в базе данных

=head2 update()

Обновление объекта.

=head1 SEE ALSO

L<ClubSpain::Model::Base>
L<ClubSpain::Model::Role::Airline>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut