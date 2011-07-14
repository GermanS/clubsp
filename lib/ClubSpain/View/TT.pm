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
        }
    }
);

1;
