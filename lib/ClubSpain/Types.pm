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

__PACKAGE__->meta->make_immutable();

1;
