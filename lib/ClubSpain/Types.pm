package ClubSpain::Types;

use strict;
use warnings;

use ClubSpain::Exception;

use DateTime;
use DateTime::Format::Strptime;
use Moose::Util::TypeConstraints;

subtype 'Natural'
    => as 'Int'
    => where { $_ > 0 }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "This number $_ is not a positive integer!"
        )
    };

subtype 'NaturalLessThan1000'
    => as 'Natural'
    => where { $_ < 1000 }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "This number $_ is not less than 1000!"
        )
    };

subtype 'NaturalLessThan10000'
    => as 'Natural'
    => where { $_ < 10000 }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "This number $_ is not less than 10000!"
        )
    };

subtype 'AlphaLength1'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{1}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 1 char!"
        )
    };

subtype 'AlphaLength2'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{2}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 2 chars word!"
        )
    };

subtype 'AlphaLength3'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{3}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 3 chars word!"
        )
    };

subtype 'AlphaLength4'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{4}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 4 chars word!"
        )
    };

subtype 'StringLength2to255'
    => as 'Str'
    => where { $_ && $_ =~ /^.{2,255}$/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is less than 2 or more than 255 chars"
        )
    };

subtype 'StringLength2to50'
    => as 'Str'
    => where { $_ && $_ =~ /^.{2,50}$/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is less than 2 or more than 50 chars"
        )
    };

subtype 'AlphaNumericLength2'
    => as 'Str'
    => where { $_ && $_ =~ /^\w{2}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 2 chars word!"
        )
    };

subtype 'AlphaNumericLength3'
    => as 'Str'
    => where { $_ && $_ =~ /^\w{3}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 3 chars word!"
        )
    };

subtype 'AlphaNumericLength4'
    => as 'Str'
    => where { $_ && $_ =~ /^\w{4}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 4 chars word!"
        )
    };

subtype 'BIC'
    => as 'Natural'
    => where {
        length  $_ == 9  &&  $_ =~ /^04/  &&  $_ !~ /00[3-9]$|0[1-4]\d$/;
    }
    => message {
        throw ClubSpain::Exception::Validation(
            message => 'BIC must be 9 digit number, begins 04 and ends 000-002, 050-999'
        )
    };

subtype 'Account'
    => as 'Natural'
    => where { length $_ == 20 }
    => message {
        throw ClubSpain::Exception::Validation(
            message => 'This must be a 20 digit number'
        )
    };

subtype 'INN'
    => as 'Natural'
    => where {
        my $value = shift;

        my $result = 0;
        if (length $value == 10) {
            #вычисление контрольной суммы 10 значного ИНН
            my @weights = qw(2 4 10 3 5 9 4 6 8 0);
            for (my $i = 0; $i < 10; $i++) {
                $result += substr($value, $i, 1) * $weights[$i];
            }

            $result = substr($value, 9, 1) == ($result % 11 % 10);
        } elsif (length $value == 12) {
            #вычисление контрольной суммы 12 значного ИНН (ИП)
            my @weights = qw(3 7 2 4 10 3 5 9 4 6 8 0);

            my $result_11 = 0;
            for (my $i = 0; $i < 11; $i++) {
                $result_11 += substr($value, $i, 1) * $weights[ $i + 1 ];
            }

            my $result_12 = 0;
            for (my $i = 0;  $i < 12; $i++) {
                $result_12 += substr($value, $i, 1) * $weights[$i];
            }

            $result =
                substr($value, 10, 1) == ($result_11 % 11 % 10) &&
                substr($value, 11, 1) == ($result_12 % 11 % 10);
        }

        return $result;
    }
    => message {
        throw ClubSpain::Exception::Validation(
            message => 'контрольная сумма ИНН неверна'
        )
    };

subtype 'OKPO'
    => as 'Natural'
    => where {
        my $value = shift;

        return 0 unless (length($value) == 8) || (length($value) == 10);

        my $result1 = 0;
        my $result2 = 0;
        for (my $i = 0; $i < length($value) - 1; $i++) {
            $result1 += substr($value, $i, 1) * ( ($i + 1) % 11 );
            $result2 += substr($value, $i, 1) * ( ($i + 3) % 11 );
        }

        return
            (($result1 % 11) > 9)
                ? substr($value, length($value) - 1, 1) == $result2 % 11 % 10
                : substr($value, length($value) - 1, 1) == $result1 % 11;
    }
    => message {
        throw ClubSpain::Exception::Validation(
            message => 'контрольная сумма ОКПО неверна'
        );
    };

subtype 'PhoneNumber'
    => as 'Natural'
    => where { length($_) == 10;}
    =>message {
        throw ClubSpain::Exception::Validation(
            message => 'Номер телефона состоит из 10 цифр'
        )
    };

subtype 'LocalPhoneNumber'
    => as 'PhoneNumber'
    => where { $_ !~ /^9/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => 'Номер городского телефона неверен'
        )
    };

subtype 'MobilePhoneNumber'
    => as 'PhoneNumber'
    => where { $_ =~ /^9/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => 'Номер мобильного телефона неверен'
        )
    };

class_type 'DateTime';
coerce 'DateTime'
    => from 'Str'
    => via {
        my $format = DateTime::Format::Strptime->new(
                locale  => 'ru_RU',
                pattern => '%F',
        );
        return $format -> parse_datetime( $_ );
    };

=head

subtype 'myDateTime' => as class_type( 'DateTime' );
coerce 'myDateTime'
    => from 'Str'
    => via {
        my $format = DateTime::Format::Strptime->new(
                locale  => 'ru_RU',
                pattern => '%FT%T',
        );
        return $format -> parse_datetime($_);
    };

=cut

1;
