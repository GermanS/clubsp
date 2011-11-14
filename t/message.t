use Test::More tests => 23;
use strict;
use warnings;
use utf8;

use_ok('ClubSpain::Message');

{
    my $msg = ClubSpain::Message->new(message => 'the message');
    isa_ok($msg, 'ClubSpain::Message');
    is($msg->message, 'the message', 'got message');
}

#ok
{
    my $msg = ClubSpain::Message::Ok->new(message => 'ok message');
    isa_ok($msg, 'ClubSpain::Message::Ok');
    is($msg->class, 'success', 'got success class');
    is($msg->message, 'ok message', 'got ok message');
}

#info
{
    my $msg = ClubSpain::Message::Info->new(message => 'info message');
    isa_ok($msg, 'ClubSpain::Message::Info');
    is($msg->class, 'info', 'got info class');
    is($msg->message, 'info message', 'got info message');
}

#warning
{
    my $msg = ClubSpain::Message::Warning->new(message => 'warning message');
    isa_ok($msg, 'ClubSpain::Message::Warning');
    is($msg->class, 'warning', 'got warning class');
    is($msg->message, 'warning message', 'got warning message');
}

#error
{
    my $msg = ClubSpain::Message::Error->new(message => 'error message');
    isa_ok($msg, 'ClubSpain::Message::Error');
    is($msg->class, 'error', 'got error class');
    is($msg->message, 'error message', 'got error message');
}


#ok()
{
    my $msg = ClubSpain::Message->ok('ok message');
    isa_ok($msg, 'ClubSpain::Message::Ok');
    is($msg->message, 'ok message', 'got ok message');
}

#info()
{
    my $msg = ClubSpain::Message->info('info message');
    isa_ok($msg, 'ClubSpain::Message::Info');
    is($msg->message, 'info message', 'got info message');
}

#warning()
{
    my $msg = ClubSpain::Message->warning('warning message');
    isa_ok($msg, 'ClubSpain::Message::Warning');
    is($msg->message, 'warning message', 'got warning message');
}

#error()
{
    my $msg = ClubSpain::Message->error('error message');
    isa_ok($msg, 'ClubSpain::Message::Error');
    is($msg->message, 'error message', 'got error message');
}
