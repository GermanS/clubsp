use Test::More tests => 3;

use strict;
use warnings;

{
    package MyDecorator;
    use Moose;
    use ClubSpain::Types;

    has 'date' => (
        is       => 'ro',
        required => 1,
        isa      => 'DateTime',
        coerce   => 1
    );
}

my $decorator = MyDecorator -> new( date => '2013-03-02' );

isa_ok $decorator, 'MyDecorator';
isa_ok $decorator -> date, 'DateTime';

is $decorator -> date -> ymd(), '2013-03-02'
    => sprintf "check date field: %s", $decorator -> date -> ymd();