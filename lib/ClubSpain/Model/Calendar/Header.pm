package ClubSpain::Model::Calendar::Header;

use Moose;
use namespace::autoclean;
use utf8;

use DateTime;
use ClubSpain::Model::Calendar::Settings;

has 'header' => (
    is => 'rw'
);

=head format($length)

Форматировние заголовка таблицы.
На входе:
 - $max - количество столбцов календаря

На выходе
 - ссылка на массив аббривиатур дней недели

=cut

sub format {
    my ($self, $length) = shift;

    my $settings = ClubSpain::Model::Calendar::Settings->new();
    my $now   = DateTime->now( locale => $settings->locale);

    my $count = 0;
    my @days  = ();

    while ($count < $length) {
        push @days,
         $now->{'locale'}->day_format_abbreviated->[$count % 7];

        $count++;
    }

    $self->header(\@days);
}


__PACKAGE__->meta()->make_immutable();

1;

