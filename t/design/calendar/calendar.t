use Test::More tests => 13;

use strict;
use warnings;
use utf8;

use DateTime;

use_ok('ClubSpain::Model::Calendar');

my $now = DateTime->now( locale => 'ru_RU' );

#empty constructor
{
    my $cal = ClubSpain::Model::Calendar->new();
    isa_ok($cal, 'ClubSpain::Model::Calendar');

    my $first = DateTime->new(
        year  => $now->year,
        month => $now->month,
        day   => 1
    );
    is_deeply($cal->start, $first, 'check start field');

    my $end = $first->add(months => 7);
    is_deeply($cal->end, $end, 'check end field');
}

#pass start and end dates
{
    my $start = DateTime->new( year => 2011, month => 7, day => 1, locale => 'ru_RU' );
    my $end   = DateTime->new( year => 2011, month => 9, day => 1, locale => 'ru_RU' );

    my $cal = ClubSpain::Model::Calendar->new(start => $start, end => $end);
    isa_ok($cal, 'ClubSpain::Model::Calendar');

    is_deeply($cal->start, $start, 'check start field');
    is_deeply($cal->end, $end, 'check end field');
}

#pass only start
{
    my $start = DateTime->new(year => 2011, month => 8, day => 1, locale => 'ru_RU' );

    my $cal = ClubSpain::Model::Calendar->new( start => $start );
    isa_ok($cal, 'ClubSpain::Model::Calendar');

    is_deeply($cal->start, $start, 'check start field');
    is_deeply($cal->end, $start->add(months => $cal->settings->months), 'check end date');
}


#
#       Пн Вт Ср Чт Пт Сб Вс Пн Вт Ср Чт Пт Сб Вс Пн Вт Ср Чт Пт Сб Вс Пн Вт Ср Чт Пт Сб Вс Пн Вт Ср Чт Пт Сб Вс
#Июнь         1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
#Июль               1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
#Август 1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
#
{
    my $start = DateTime->new( year => 2011, month => 6, day => 1 );
    my $end   = DateTime->new( year => 2011, month => 9, day => 1 );

    my $jun = ClubSpain::Model::Calendar::Month->new( date => DateTime->new( year => 2011, month => 6, day => 1, locale => 'ru_RU'));
    my $jul = ClubSpain::Model::Calendar::Month->new( date => DateTime->new( year => 2011, month => 7, day => 1, locale => 'ru_RU'));
    my $aug = ClubSpain::Model::Calendar::Month->new( date => DateTime->new( year => 2011, month => 8, day => 1, locale => 'ru_RU'));

    my $cal = ClubSpain::Model::Calendar->new(start => $start, end => $end );
    isa_ok($cal, 'ClubSpain::Model::Calendar');
    is($cal->length, 35, 'got calendar columns');
    is_deeply($cal->months, [$jun, $jul, $aug], 'check months');
}


=cut


#my @days = $cal->format_days_of_week();
#my @months = $cal->format_months();

#binmode STDOUT, ":utf8";
#warn $_ for @days;
#warn $_ for @months;
#printf("%s\n", $_) for @days;


#use Data::Dumper;
#warn Dumper(\@days);

#название месяца в именитеьлном падеже
#$now->{'locale'}->month_stand_alone_wide->[ $now->month ]



