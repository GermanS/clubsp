package ClubSpain::Exception;

use strict;
use warnings;

use Exception::Class (
    'ClubSpain::Exception::Base' => {
        description => 'base exception',
        fields      => [qw(message)]
    },
    'ClubSpain::Exception::Validation' => {
        isa         => 'ClubSpain::Exception::Base',
        description => 'validation exception',
    },
    'ClubSpain::Exception::Storage' => {
        isa         => 'ClubSpain::Exception::Base',
        description => 'storage exception'
    },
);


use Moose::Util::TypeConstraints;

class_type 'ClubSpain::Exception::Base';
class_type 'ClubSpain::Exception::Validation';
class_type 'ClubSpain::Exception::Storage';

no Moose::Util::TypeConstraints;

1;

__END__

=head1 NAME

ClubSpain::Exception - Exceptions used within ClubSpain

=head1 SYNOPSIS

    use ClubSpain::Profile;
    use ClubSpain::Exception;

    eval {
        ClubSpain::Model::Trader->new(...);
    };

    my $e;
    if ($e = Exception::Class->caught('MyException')) {
        ... process exception ...
    } else {
        ... do somesthing else ...
    }

=head1 DESCRIPTION

ClubSpain::Exception subclasses L<Exception::Class|Exception::Class> and
attempts to throw exceptions when unexpected things happen.

=head1 EXCEPTIONS

=head2 ClubSpain::Exception::Base

This is the base exception thrown in C<ClubSpain>. All other exceptions subclass
C<ClubSpain::Exception> so it's possible to catch all ClubSpain generated exceptions
with a single C<catch> statement.

    eval  {
        ...
        ClubSpain::Exception::Argument->throw(message => 'my message');
        ...
    };
    my $e
    if ($e = Exception::Class->caught('ClubSpain::Exception::Base')) {
        print 'Something bad happened in ClubSpain: ' . $e->message;
    } else {
        print 'Something bad happened in MyApplication';
    };

See L<Exception::Class> for more information on how to use exceptions.

=head2 ClubSpain::Exception::Constraint

This exception is thrown if a database constraint is violated. This is true for
both raw DBI database constraint errors as well as field updates that don't
pass constraints.

=head2 ClubSpain::Exception::Validation

This exception is thrown if the validation component returned a result object,
that can be found in $E-E<gt>message.

=head2 ClubSpain::Exception::Storage

This exception is thrown if there are any configuration or setup errors in
ClubSpain::Storage.

=head2 ClubSpain::Exception::Argument

This exception is thrown when an invalid or unexpected argument value is passed
into methods.

=head1 METHODS

=head2 message()

Returns the details portion of the exception message if there are any.

=head1 SEE ALSO

L<Exception::Class>, L<ClubSpain::Constraints>

=head1 AUTHOR

    German Semenkov
    german.semenkov@gmail.com
    http://clubspain.com/
