package ClubSpain::Model::Country;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Country' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'name' => (
    is      => 'rw',
    isa     => 'StringLength2to255',
    reader  => 'get_name',
    writer  => 'set_name',
);
has 'alpha2' => (
    is      => 'rw',
    isa     => 'AlphaLength2',
    reader  => 'get_alpha2',
    writer  => 'set_alpha2',
);
has 'alpha3' => (
    is      => 'rw',
    isa     => 'AlphaLength3',
    reader  => 'get_alpha3',
    writer  => 'set_alpha3',
);
has 'numerics' => (
    is      => 'rw',
    isa     => 'NaturalLessThan1000',
    reader  => 'get_numerics',
    writer  => 'set_numerics',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Country';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

sub params {
    my $self = shift;

    return  {
        name         => $self -> get_name(),
        alpha2       => $self -> get_alpha2(),
        alpha3       => $self -> get_alpha3(),
        numerics     => $self -> get_numerics(),
        is_published => $self -> get_is_published(),
    };
}

sub searchCountriesOfDeparture {
    my $self = shift;

    return
        $self -> schema()
              -> resultset( $self -> source_name() )
              -> searchCountriesOfDeparture();
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Country

=head1 SYNOPSIS

use ClubSpain::Model::Country;
my $object = ClubSpain::Model::Country -> new(
    id           => $id,
    name         => $name,
    alpha2       => $alpha2,
    alpha3       => $aplha3,
    numerics     => $number,
    is_published => $flag,
);

my $res = $object -> create();
my $res = $object -> update();

my $iterator = $object -> searchCountriesOfDeparture();

=head1 DESCRIPTION

Страна

=head1 FIELDS

=head2 id

Идентификатор страны

=head2 name

Название страны

=head2 alpha2

Двухбуквенных код страны

=head2 alpha3

Трехбуквенных код страны

=head2 numerics

Цифровой код страны

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Добавление записи в базу данных

=head2 update()

Обновление записы в базе данных

=head2 searchCountriesOfDeparture()

#TODO: проверить, используется ли этот метод
Поиск стран их которых возможно отправление

=head1 SEE ALSO

L<ClubSpain::Model::Role::Country>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut



