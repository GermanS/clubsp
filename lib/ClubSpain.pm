package ClubSpain;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw(
    -Debug
    ConfigLoader
    Static::Simple
    Server
    Server::XMLRPC
    Server::JSONRPC
    Unicode
);

extends 'Catalyst';

our $VERSION = '0.04';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in clubspain.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'ClubSpain',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    xmlrpc => {
        'xml_encoding' => 'utf-8',
        'path' => qr!^(/?)xmlrpc(/|$)!i
    },
    jsonrpc => {
        'path' => qr!^(/?)jsonrpc(/|$)!i
    },
    default_view => 'TT',
    'View::TT' => {
         ENCODING => 'utf-8',
    },
    'Controller::HTML::FormFu' => {
        constructor => {
            tt_args => {
                ENCODING => 'UTF-8',
            },
        },
    },
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

ClubSpain - Catalyst based application

=head1 SYNOPSIS

    script/clubspain_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<ClubSpain::Controller::Root>, L<Catalyst>

=head1 AUTHOR

german.semenkov@gmail.com

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
