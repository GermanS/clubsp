package ClubSpain::Design::City;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use ClubSpain::Common qw(minify);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'country_id'    => ( is => 'ro', required => 1 );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );



sub create {
    my $self = shift;

    $self->schema->resultset('City')->create({
        country_id   => $self->country_id,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

1;
