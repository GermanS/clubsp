package ClubSpain::Model::DBIC;

use strict;
use warnings;

use base qw(Catalyst::Model::DBIC::Schema);

__PACKAGE__->config( schema_class => 'ClubSpain::Schema' );

1;
