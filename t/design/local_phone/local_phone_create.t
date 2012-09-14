use Test::More tests => 6;
use strict;
use warnings;

use_ok('ClubSpain::Model::LocalPhone');

my $params = { office_id => 1, number => 4957654321 };
my $phone = ClubSpain::Model::LocalPhone->new( $params );

my $result;
eval {
    $result = $phone->create();
    pass('no exception thrown');
};

if ($@) {
    fail('caught exception');
    use Data::Dumper;
    diag Dumper($@);
}

isa_ok($result, 'ClubSpain::Schema::Result::LocalPhone');
is $result->office_id, $params->{'office_id'}
    => 'got office id';
is $result->number, $params->{'number'}
    => 'got office id';
is $result->is_published, 1
    => 'got is published flag';
