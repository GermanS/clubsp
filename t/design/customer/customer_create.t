use Test::More tests => 17;
use strict;
use warnings;

use_ok('ClubSpain::Model::Customer');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $customer = ClubSpain::Model::Customer->new(
        name         => 'Иван',
        surname      => 'Иванов',
        email        => 'ivan@ivanov.com',
        passwd       => 'passwd',
        mobile       => '9101234567',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $customer->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Customer');
    is($customer->name, 'Иван', 'got name');
    is($customer->surname, 'Иванов', 'got surname');
    is($customer->email, 'ivan@ivanov.com', 'got email');
    is($customer->passwd, 'passwd', 'got passwd');
    is($customer->mobile, '9101234567', 'gort mobile');
    is($customer->is_published, 1, 'got is published');
}

#second addition
{
    my $customer = ClubSpain::Model::Customer->new(
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'jose@yahoo.com',
        passwd      => 'passwd',
        mobile      => '605458224',
        is_published => 1,
    );

    my $result;

    eval {
        $result = $customer->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Customer');
    is($customer->name, 'Jose', 'got name');
    is($customer->surname, 'Cuesta', 'got surname');
    is($customer->email, 'jose@yahoo.com', 'got email');
    is($customer->passwd, 'passwd', 'got passwd');
    is($customer->mobile, '605458224', 'gort mobile');
    is($customer->is_published, 1, 'got is published');
}
