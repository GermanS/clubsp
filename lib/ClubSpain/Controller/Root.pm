package ClubSpain::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;
BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

ClubSpain::Controller::Root - Root Controller for ClubSpain

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $iterator = $c->model('Article')->list(1);

    $c->stash(
        iterator => $iterator,
        template => 'common/index.tt2'
    );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub article   : Chained('/') : PathPart('article') : CaptureArgs(0) { }
sub charter   : Chained('/') : PathPart('charter') : CaptureArgs(0) { }
sub aviabilet : Chained('/') : PathPart('aviabilet') : CaptureArgs(0) { }

=head2 end

Attempt to render a view, if needed.

=cut

sub end :Private {
  my ($self, $c) = @_;
  $c->forward('render') unless $c->req->xmlrpc->is_xmlrpc_request;
}

sub render :ActionClass('RenderView') { }

=head1 AUTHOR

German Semenkov german.semenkov@gmail.com

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
