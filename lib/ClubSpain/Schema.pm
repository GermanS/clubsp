package ClubSpain::Schema;

use strict;
use warnings;

use parent qw(DBIx::Class::Schema);
use Config::Any;

__PACKAGE__->load_namespaces(
    default_resultset_class => '+ClubSpain::Schema::ResultSet'
);

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

        $dsn = $config->{'Model::DBIC::Schema'}{'connect_info'}{'dsn'}
            unless $dsn;

        $user = $config->{'Model::DBIC::Schema'}{'connect_info'}{'user'}
            unless $user;

        $pass = $config->{'Model::DBIC::Schema'}{'connect_info'}{'password'}
            unless $pass;

        $opts->{'mysql_enable_utf8'} = $config->{'Model::DBIC::Schema'}{'connect_info'}{'mysql_enable_utf8'}
            unless $opts->{'mysql_enable_utf8'};
    }

    return $self->next::method($dsn, $user, $pass, $opts);
}

1;
