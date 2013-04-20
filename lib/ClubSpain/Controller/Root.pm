package ClubSpain::Controller::Root;

use strict;
use warnings;
use utf8;

use namespace::autoclean;
use Moose;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__ -> config( namespace => '' );

sub index :Path :Args(1) {
    my ( $self, $c, $direction ) = @_;

    my ($codeOfDeparture, $codeOfArrival) = split( '-', $direction);
    if ($codeOfDeparture && $codeOfArrival) {
        my $cityOfDeparture = $c -> model( 'City' ) -> search({ iata => $codeOfDeparture, is_published => 1 }) -> single;
        my $cityOfArrival   = $c -> model( 'City' ) -> search({ iata => $codeOfArrival,   is_published => 1 }) -> single;

        $c -> detach( 'default' ) unless $cityOfDeparture && $cityOfArrival;

        $c -> request -> param( 'CityOfArrival_id',   $cityOfArrival   -> id );
        $c -> request -> param( 'CityOfDeparture_id', $cityOfDeparture -> id );
        $c -> request -> param( 'CityOfDeparture',  sprintf("%s (%s)", $cityOfDeparture -> name_ru, $cityOfDeparture -> iata));
        $c -> request -> param( 'CityOfArrival',    sprintf("%s (%s)", $cityOfArrival   -> name_ru, $cityOfArrival   -> iata));

        $c -> go(qw(ClubSpain::Controller::Flight), qw(default));
    }
}

sub default :Path {
    my ( $self, $c ) = @_;

    my $iterator = $c -> model( 'Article' ) -> list(1);
    $c -> stash(
        iterator => $iterator,
        template => 'common/index.tt2'
    );
}

sub article   : Chained( '/' ) : PathPart( 'article' )   : CaptureArgs(0) { }
sub charter   : Chained( '/' ) : PathPart( 'charter' )   : CaptureArgs(0) { }
sub aviabilet : Chained( '/' ) : PathPart( 'aviabilet' ) : CaptureArgs(0) { }

sub logout :Global {
    my ($self, $c) = @_;

    $c -> logout;
    undef $c -> stash -> {'user'};

    $c -> detach( 'default' );
}

sub end :Private {
    my ($self, $c) = @_;
    $c -> forward( 'render' );
}

sub render :ActionClass( 'RenderView' ) { }

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=head1 NAME

ClubSpain::Controller::Root - Root Controller for ClubSpain

=head1 DESCRIPTION

=head1 METHODS

=head2 index

The root page (/)

=head2 default

Standard 404 error page

=head2 end

Attempt to render a view, if needed.

=head1 AUTHOR

German Semenkov german.semenkov@gmail.com

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut