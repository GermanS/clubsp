package ClubSpain::Model::Airplane;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airplane' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'manufacturer_id' => (
    is      => 'rw',
    reader  => 'get_manufacturer_id',
    writer  => 'set_manufacturer_id',
);
has 'iata' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength3',
    reader  => 'get_iata',
    writer  => 'set_iata',
);
has 'icao' => (
    is      => 'rw',
    isa     => 'AlphaNumericLength4',
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

with 'ClubSpain::Model::Role::Airplane';

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

=head1 NAME

ClubSpain::Model::Airplane

=head1 SYNOPSIS

use ClubSpain::Model::Airplane;
my $object = ClubSpain::Model::Airplane -> new(
    id              => $id,
    iata            => $iata,
    icao            => $icao,
    name            => $name,
    is_published    => $flag,
    manufacturer_id => $manufacturer_id,
);

if( $object -> validate_iata() ) { ... }
if( $object -> validate_icao() ) { ... }
if( $object -> validate_name() ) { ... }
if( $object -> validate_manufacturer_id() ) { ... }

my $res = $object -> create();
my $res = $object -> update();
my $res = $object -> delete();

=head1 DESCRIPTION

Марка (модель) самолета

=head1 METHODS

=head2 create()

Сохрание объекта в базе данных

=head2 update()

Обновление объекта в базе данных

=head1 SEE ALSO

L<ClubSpain::Model::Role::Airplane>
L<ClubSpain::Model::Base>

http://skalolaskovy.narod.ru/avia/type_of_aircrafts.html

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut