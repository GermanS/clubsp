package ClubSpain::Schema;

use strict;
use warnings;

use Config::Any;

use parent qw(DBIx::Class::Schema);

__PACKAGE__->load_namespaces(
    default_resultset_class => '+ClubSpain::Schema::ResultSet'
);

#__PACKAGE__->load_classes();

sub connect {
    my ($self, $dsn, $user, $pass, $opts) = @_;

    unless ($dsn && $user && $pass) {
        #TODO: убрать захардкоденое название фвайла конфигурации
        #варинты
        #1. использовать переменные окружения %ENV
        #2. поиск и разбор файла как в Catalyst::Plugin::ConfigReader
        my $file = 'clubspain.conf';
        my $config = Config::Any->load_files({
            files   => [$file],
            use_ext => 1
        })->[0]->{$file};

        $dsn = $config->{'Model::DBIC'}{'connect_info'}{'dsn'}
            unless $dsn;

        $user = $config->{'Model::DBIC'}{'connect_info'}{'user'}
            unless $user;

        $pass = $config->{'Model::DBIC'}{'connect_info'}{'password'}
            unless $pass;
    }

    return $self->next::method($dsn, $user, $pass, $opts);
}

1;
