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
    Authentication
    ConfigLoader
    Session
    Session::State::Cookie
    Session::Store::FastMmap
    Static::Simple
    Unicode
);

#Server

extends 'Catalyst';

our $VERSION = '0.09';
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
    default_view => 'TT',
    'View::TT' => {
         ENCODING => 'UTF-8',
    },
    'View::JSON' => {
        expose_stash => 'json_data'
    },
    'Plugin::Session' => {
        expires => 3600,
        storage => '/tmp/clubsp_session'
    },
    'Plugin::Authentication' => {
        default_realm => 'employee',
        realms => {
            employee => {
                credential => {
                    class => 'Password',
                    password_field => 'password',
                    password_type => 'clear'
                },
                store => {
                    class => 'DBIx::Class',
                    user_model => 'Employee',
#                    role_relation => 'roles',
#                    role_field => 'rolename',
                }
            }
        }
    }
);

# Start the application
__PACKAGE__ -> setup();

1;

__END__

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


