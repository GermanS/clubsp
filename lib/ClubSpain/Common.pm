package ClubSpain::Common;

use strict;
use warnings;
use utf8;

use vars qw(@EXPORT_OK %EXPORT_TAGS);

BEGIN {
    use base qw(Exporter);
};

@EXPORT_OK = qw(&minify);

%EXPORT_TAGS = ( all => \@EXPORT_OK );

sub minify {
    my $value = shift;
    return unless $value;

    $value =~ s/^\s+//;
    $value =~ s/\s+$//;
    $value =~ s/\s{2,}/ /g;

    return $value;
}

1;
