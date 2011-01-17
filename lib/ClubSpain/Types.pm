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
            message => sprintf "This number %s is not a positive integer!", $_
        )
    };

subtype 'NaturalLessThan1000'
    => as 'Natural'
    => where { $_ < 1000 }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "This number %s is not less than 1000!", $_
        )
    };

subtype 'AlphaLength1'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{1}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 1 char!", $_
        )
    };

subtype 'AlphaLength2'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{2}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 2 chars word!", $_
        )
    };

subtype 'AlphaLength3'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{3}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 3 chars word!", $_
        )
    };

subtype 'AlphaLength4'
    => as 'Str'
    => where { $_ && $_ =~ /^[a-z]{4}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 4 chars word!", $_
        )
    };

subtype 'StringLength2to255'
    => as 'Str'
    => where { $_ && $_ =~ /^.{2,255}$/ }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is less than 2 or more than 255 chars", $_
        )
    };

subtype 'AlphaNumericLength2'
    => as 'Str'
    => where { $_ && $_ =~ /^\w{2}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 2 chars word!", $_
        )
    };

subtype 'AlphaNumericLength3'
    => as 'Str'
    => where { $_ && $_ =~ /^\w{3}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 3 chars word!", $_
        )
    };

subtype 'AlphaNumericLength4'
    => as 'Str'
    => where { $_ && $_ =~ /^\w{4}$/i }
    => message {
        throw ClubSpain::Exception::Validation(
            message => sprintf "The %s is not 4 chars word!", $_
        )
    };

__PACKAGE__->meta->make_immutable();

1;
