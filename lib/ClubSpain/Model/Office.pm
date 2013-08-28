package ClubSpain::Model::Office;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Office' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'company_id' => (
    is      => 'rw',
    reader  => 'get_company_id',
    writer  => 'set_company_id',
);
has 'zipcode' => (
    is      => 'rw',
    reader  => 'get_zipcode',
    writer  => 'set_zipcode',
);
has 'street' => (
    is      => 'rw',
    reader  => 'get_street',
    writer  => 'set_street',
);
has 'name'  => (
    is      => 'rw',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'is_published' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 1,
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

sub params {
    my $self = shift;

    return {
        company_id  => $self -> get_company_id(),
        zipcode     => $self -> get_zipcode(),
        street      => $self -> get_street(),
        name        => $self -> get_name(),
        is_published => $self -> get_is_published()
    };
}

__PACKAGE__ -> meta() -> make_immutable;

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Office

=head1 SYNOPSIS

use ClubSpain::Model::Office;
my $object = ClubSpain::Model::Office -> new(
    id           => $id,
    company_id   => $company,
    zipcode      => $zipcode,
    street       => $street,
    name         => $name,
    is_published => $flag,
);

my $res = $object -> create();
my $res = $object -> update();

=head1 DESCRIPTION

Офис компании(предприятия)

=head1 FIELDS

=head2 id

Идентификатор офиса

=head2 company_id

Иденфтификатор компании

=head2 zipcode

Почтовый индекс офиса

=head2 street

Адрес

=head2 name

Название офиса

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Добавление записи в базу данных

=head2 update()

Редактирование записи в базе данных

=head2 params()

#TODO: документация для params()

=head1 SEE ALSO

L<Moose>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut
