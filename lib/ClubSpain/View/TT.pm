package ClubSpain::View::TT;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::View::TT);

use DateTime;
use DateTime::Format::Strptime;
use Encode;
use Text::GooglewikiFormat;

__PACKAGE__->config(
    ENCODING            => 'UTF-8',
    TEMPLATE_EXTENSION  => 'tt2',
    PRE_CHOMP           => 2,
    POST_CHOMP          => 2,
    INCLUDE_PATH        => [ ClubSpain->path_to('root', 'base') ],
    FILTERS => {
        'wiki' => sub {
            my $text  = shift;

            my %tags = %Text::GooglewikiFormat::tags;
            return Text::GooglewikiFormat::format( $text );
        },
        'utf8' => sub {
            my $value = shift;

            if ( defined $value and !ref $value ) {
                if ( $] <= 5.008000 ) {
                    Encode::_utf8_on($value) unless Encode::is_utf8($value);
                } else {
                    utf8::decode($value) unless utf8::is_utf8($value);
                }
            }

            $value;
        },
        'time' => sub {
            my $value = shift;

            my $format_in = DateTime::Format::Strptime->new(
                pattern     => '%T', #H:M:S
                locale      => 'ru_RU',
            );
            my $format_out = DateTime::Format::Strptime->new(
                pattern     => '%R', #H:M
                locale      => 'ru_RU',
            );
            my $dt = $format_in->parse_datetime($value);

            return $format_out->format_datetime($dt)
        },
        'date' => sub {
            my $value = shift;

            my $format = DateTime::Format::Strptime->new(
                locale  => 'ru_RU',
                pattern => '%F',
            );
            my $dt = $format->parse_datetime($value);

            return $dt->format_cldr( $dt->locale()->date_format_full() );
        },
        'dmy' => sub {
            my $value = shift;

            my $format = DateTime::Format::Strptime->new(
                locale  => 'ru_RU',
                pattern => '%F',
            );
            my $dt = $format->parse_datetime($value);

            return $dt->dmy;
        },
        'dow' => sub {
            my $value = shift;

            my $format = DateTime::Format::Strptime->new(
                locale  => 'ru_RU',
                pattern => '%F',
            );
            my $dt = $format->parse_datetime($value);

            return $dt->locale()->day_stand_alone_abbreviated()->[$dt->day_of_week_0];
        },
        'commify' => sub {
            my $value = shift;
            $value = reverse $value;
            $value =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1 /g;
            $value = reverse $value;
            return $value;
        }
    }
);

1;
