package ClubSpain::Schema::Result;
use strict;
use warnings;
use utf8;
use parent qw(DBIx::Class);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    $sqlt_table->extra(
        mysql_table_type => 'InnoDB',
        mysql_charset    => 'utf8'
    );
}

1;

=head1 NAME

    ClubSpain::Schema::Result - base class for Result classes

=head1 DESCRIPTION

    Base class for all result classes below the ClubSpain::Schema::Result::* namespace.

=head1 LICENSE

    This library is free software. You can redistribute it and/or modify
    it under the same terms as Perl itself.
