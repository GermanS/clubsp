package Template::Plugin::ClubSpain::Calendar;

use strict;
use warnings;
use utf8;

sub new {
    my ($class, $context, @params) = @_;

    my $self = bless { _CONTEXT => $context }, 'Template::Plugin::ClubSpain::Calendar::Proxy';

    return $self;
}

sub load {
    my ($class, $context) = @_;

    return $class;
}



package Template::Plugin::ClubSpain::Calendar::Proxy;
use strict;
use warnings;
use utf8;

use base qw(ClubSpain::Model::Calendar);


1;
