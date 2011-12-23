package ClubSpain::Model::SEO::Itinerary;
use namespace::autoclean;
use Moose;
use utf8;

=head2 direction_title($segment)

Формирование простого заголовка web страницы с названием городов отправления
и прибытия.

На входе:
    $segment - объект типа 'Schema::Result::Itinerary'

На выходе:

    "Стоимость авиабилета Москва - Барселона"
        - если авиабилет в одну сторону

    "Стоимость авиабилета Москва - Барселона - Москва"
        - если авиабилет туда и обратно

    "Стоимость авиабилета Москва - Барселона, Аликанте - Москва"
        - если город отправления второго сегмента не равен городу прибытия первого

=cut

sub direction_title {
    my ($self, $segment1) = @_;

    my $result;
    my $segment2 = $segment1->next_route();
    if ($segment2) {
        if ($segment1->timetable->flight->departure_airport->city->name_ru eq
            $segment1->timetable->flight->destination_airport->city->name_ru) {
            $result = sprintf "Стоимость авиабилета %s - %s - %s",
                $segment1->timetable->flight->departure_airport->city->name_ru,
                $segment1->timetable->flight->destination_airport->city->name_ru,
                $segment2->timetable->flight->destination_airport->city->name_ru,
        } else {
            $result = sprintf "Стоимость авиабилета %s - %s, %s - %s",
                $segment1->timetable->flight->departure_airport->city->name_ru,
                $segment1->timetable->flight->destination_airport->city->name_ru,
                $segment2->timetable->flight->departure_airport->city->name_ru,
                $segment2->timetable->flight->destination_airport->city->name_ru,
        }
    } else {
        $result = sprintf "Стоимость авиабилета %s - %s",
            $segment1->timetable->flight->departure_airport->city->name_ru,
            $segment1->timetable->flight->destination_airport->city->name_ru;
    }

    return $result;
}


=head2 direction_title_with_date($segment1)

Формирование простого заголовка web страницы с названием городов отправления
и прибытия.

На входе:
    $segment1 - объект типа 'Schema::Result::Itinerary'

На выходе:

    "Стоимость авиабилета Москва - Барселона, вылет 2011-01-01"
        - если авиабилет в одну сторону

    "Стоимость авиабилета Москва - Барселона - Москва с 2011-01-01 по 2011-01-08"
        - если авиабилет туда и обратно

    "Стоимость авиабилета Москва - Барселона, Аликанте - Москва с 2011-01-01 по 2011-01-08"
        - если город отправления второго сегмента не равен городу прибытия первого

=cut

sub direction_title_with_date {
    my ($self, $segment1) = @_;

    my $result = $self->direction_title($segment1);

    my $segment2 = $segment1->next_route();
    $result .= ($segment2)
        ? sprintf " c %s по %s",
            $segment1->timetable->departure_date,
            $segment2->timetable->departure_date
        : sprintf ", вылет %s",
            $segment1->timetable->departure_date;

    return $result;
}

__PACKAGE__->meta->make_immutable();

1;
