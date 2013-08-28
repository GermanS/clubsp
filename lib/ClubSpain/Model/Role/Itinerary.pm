package ClubSpain::Model::Role::Itinerary;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_timetable_id    set_timetable_id
    get_fare_class_id   set_fare_class_id
    set_cost            get_cost
);

sub validate_timetable_id  { 1; }
sub validate_fare_class_id { 1; }
sub validate_parent_id     { 1; }
sub validate_cost          { 1; }

sub notify {
    my ($self, $object) = @_;

    $self -> set_timetable_id( $object -> get_timetable_id() );
    $self -> set_fare_class_id( $object -> get_fare_class_id() );
    $self -> set_return_segment( $object -> get_return_segment() );
    $self -> set_cost( $object -> get_cost() );

    return;
}

sub params {
    my $self = shift;

    return {
        is_published  => $self -> get_is_published(),
        timetable_id  => $self -> get_timetable_id(),
        fare_class_id => $self -> get_fare_class_id(),
        parent_id     => $self -> get_parent_id(),
        cost          => $self -> get_cost(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Itinerary

=head1 DESCRIPTION

Интерфейсные методы для полетных сегментов

=head1 METHODS

=head2 validate_timetable_id()

Проверка расписания

=head2 validate_fare_class_id()

Проверка класса обслуживания

=head2 validate_parent_id()

Проверка родительского сегмента

=head2 validate_cost()

Проверка стоимости

=head2 notify()

#TODO: документация notify()

=head2 params()

#TODO: документация params()

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut
