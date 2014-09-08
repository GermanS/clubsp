package ClubSpain::XML::VipService::Import::Store;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;

has 'response' => (
    is       => 'rw',
    isa      => 'ArrayRef[ClubSpain::XML::VipService::Response]',
    traits   => [ 'Array' ],
    handles  => {
        add_response   => 'push',
        all_responses  => 'elements',
        clear_response => 'clear',
        has_response   => 'count'
    }
);

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__