package ClubSpain::Types;
use strict;
use warnings;
use Moose::Util::TypeConstraints;
use ClubSpain::Exception;

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

1;
