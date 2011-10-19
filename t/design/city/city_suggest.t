use Test::More tests => 37;
use strict;
use warnings;
use utf8;
use lib qw(t/lib);
use ClubSpain::Test;

use_ok('ClubSpain::Model::City');
my $schema = ClubSpain::Test->init_schema();

{
    #search for Barcelona
    for my $word (qw(Bar BAR bar bAr)){
        my $result = ClubSpain::Model::City->suggest($word);
        is($result->count, 1, 'got one row');
        is_BCN( $result->next() );
    }
}

#search for Moscow in russian
{
    for my $word (qw(Мос москва мОС моС)){
        my $result = ClubSpain::Model::City->suggest($word);
        is($result->count, 1, 'Got one row');
        is_MOW( $result->next() );
    }
}


#search for city by IATA code;
{
    #BCN
    {
        my $result = ClubSpain::Model::City->suggest('BCN');
        is($result->count, 1, 'got one row');
        is_BCN( $result->next() );
    }

    #MOW
    {
        my $result = ClubSpain::Model::City->suggest('MOW');
        is($result->count, 1, 'got one row');
        is_MOW( $result->next() );
    }

    #in different cases
    {
        # bCn
        {
            my $result = ClubSpain::Model::City->suggest('bCn');
            is($result->count, 1, 'got one row');
            is_BCN( $result->next() );
        }

        #MoW
        {
            my $result = ClubSpain::Model::City->suggest('MoW');
            is($result->count, 1, 'got one row');
            is_MOW( $result->next() );
        }
    }
}


sub is_MOW {
    my $MOW = shift;

    is($MOW->iata, 'MOW', 'got iata code');
    is($MOW->name, 'Moscow', 'got name');
}

sub is_BCN {
    my $BCN = shift;

    is($BCN->iata, 'BCN', 'got iata code');
    is($BCN->name, 'Barcelona', 'Got name');
}

