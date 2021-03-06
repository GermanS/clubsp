package ClubSpain::Constants;
use strict;
use warnings;
use utf8;
use vars qw(@EXPORT_OK %EXPORT_TAGS);

use base qw(Exporter);

use constant DISABLE => 0;
use constant ENABLE  => 1;

use constant SOLD => 0;
use constant REQUEST => 1;
use constant FREE => 2;

use constant MESSAGE_OK  => 'Операция успешно выполнена';

@EXPORT_OK = qw(
    DISABLE
    ENABLE
    MESSAGE_OK
    SOLD
    REQUEST
    FREE
);

%EXPORT_TAGS = (
    all => \@EXPORT_OK
);

1;
