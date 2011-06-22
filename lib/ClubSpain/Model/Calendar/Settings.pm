package ClubSpain::Model::Calendar::Settings;

use Moose;
use namespace::autoclean;
use utf8;

#количество месяцев в календаре
has 'months' => ( is => 'ro', default => '7');
has 'locale' => ( is => 'ro', default => 'ru_RU' );

__PACKAGE__->meta()->make_immutable();

1;
