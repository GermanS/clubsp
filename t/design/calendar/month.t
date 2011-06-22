use Test::More tests => 8;

use strict;
use warnings;
use utf8;

use DateTime;

use_ok('ClubSpain::Model::Calendar::Month');

my $date = DateTime->new(locale => 'ru_RU', year => 2011, month => 6, day => 20);
my $month = ClubSpain::Model::Calendar::Month->new( date => $date );

isa_ok($month, 'ClubSpain::Model::Calendar::Month');
is($month->format, 'Июнь', 'got formated name');
is($month->month_length, 30, 'got month length');
is($month->calendar_length, 32, 'got calendar length');
isa_ok($month->first, 'DateTime');
is_deeply(
    $month->first,
    DateTime->new( year => 2011, month => 6, day => 1 ),
    'check the first day of month'
);

#тест с заполнением массива дат
my @days = ();
for my $day (1 .. 30) {
    my $dt = DateTime->new( year => 2011, month => 6, day => $day );
    $days[ $month->first->day_of_week - 2  + $dt->day ] = $dt;
}

is_deeply($month->days, \@days, 'check days');
