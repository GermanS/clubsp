package ClubSpain::Types;

use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

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

subtype 'AlphaLength1'
    => as 'Str'
    => where { $_ =~ /^[A-Za-z]{1}$/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 1 char!"
        )
    };

subtype 'AlphaLength2'
    => as 'Str'
    => where { $_ =~ /^[A-Za-z]{2}$/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 2 chars word!"
        )
    };

subtype 'AlphaLength3'
    => as 'Str'
    => where { $_ =~ /^[A-Za-z]{3}$/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => "The $_ is not 3 chars word!"
        )
    };

__PACKAGE__->meta->make_immutable();

1;
