use Test::More tests => 1;
use strict;
use warnings;
use utf8;

diag "implement me";
ok(1);

=head

use_ok('ClubSpain::Model::Company');
use_ok('ClubSpain::Form::BackOffice::Company');

#TODO: implement
TODO: {
    local $TODO = 'implement this';

    my $params = {
        legal_index     => '123345',
        legal_address   => 'street 10',
        actual_index    => '124445',
        actual_address  => 'street 12',
        name            => 'company name',
        nick            => 'company nick name',
        website         => 'somewhere.com',
        INN             => '7702581366',
        OKPO            => '79011171',
        OKVED           => '63.30',
        phone           => '4951234567',
        email           => 'email@mail.com',
        bank_account          => '40702810900000005219',
        correspondent_account => '30101810500000000297',
        BIC             => '044585297',
        bank            => 'bank',
        is_NDS          => 1,
    };
    my $form = ClubSpain::Form::BackOffice::Company->new();
    my $validated = $form->process($params);
    ok( $validated, 'form validated' );

    #create country from form
    {
        my $company  = $form->get_company();
        is $company->get_zipcode, $params->{'legal_index'}
            => 'got company index';
        is $company->get_street, $params->{'legal_address'}
            => 'got company address';
        is $company->get_name, $params->{'name'}
            => 'got company name';
        is $company->get_nick, $params->{'nick'}
            => 'got company nick';
        is $company->get_website, $params->{'website'}
            => 'got company website';
        is $company->get_INN, $params->{'INN'}
            => 'got company INN';
        is $company->get_OKPO, $params->{'OKPO'}
            => 'got company OKPO';
        is $company->get_OKVED, $params->{'OKVED'}
            => 'got company OKVED';
        is $company->get_is_NDS, $params->{'is_NDS'}
            => 'got gompany is NDS flag';
    }


    {
        my $account  = $form->get_bank_account();
        is $account->get_bank_account, $params->{'bank_account'}
            => 'got bank account';
        is $account->get_correspondent_account, $params->{'correspondent_account'}
            => 'got correspondent account';
        is $account->get_BIC, $params->{'BIC'}
            => 'got BIC';
        is $account->get_bank, $params->{'bank'}
            => 'got bank';
    }





    {
        my $office = $form->get_office();
        is $office->get_zipcode, $params->{'actual_index'}
            => 'got office zipcode';
        is $office->get_phone, $params->{'phone'}
            => 'got company phone';
        is $office->get_email, $params->{'email'}
            => 'got company mail';
    }



}




{
    my $params = {
        legal_index     => '000000',
        legal_address   => 'st',
        actual_index    => '000000',
        actual_address  => 'st',
        name            => 'company name',
        nick            => 'company nick name',
        website         => 'somewhere.com',
        INN             => '7702581366',
        OKPO            => '79011171',
        OKVED           => '63.30',
        phone           => '4951234567',
        email           => 'email@mail.com',
        bank_account          => '40702810900000005219',
        correspondent_account => '30101810500000000297',
        bic             => '044585297',
        bank            => 'bank',
        is_NDS          => 1,
    };
    my $form = ClubSpain::Form::BackOffice::Company->new();
    my $validated = $form->process($params);

    ok( $validated, 'form validated' );

    foreach my $error ($form->errors) {
        diag $error;
    }
}

=cut

