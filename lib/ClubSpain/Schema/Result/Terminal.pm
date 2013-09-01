package ClubSpain::Schema::Result::Terminal;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);

__PACKAGE__ -> table('terminal');
__PACKAGE__ -> source_name('Terminal');
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    airport_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    name => {
        data_type   => 'char',
        size        => 255,
        is_nullable => 0,
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
);

__PACKAGE__ -> set_primary_key('id');

__PACKAGE__ -> has_many(
    departures => 'ClubSpain::Schema::Result::TimeTable', {'foreign.departure_terminal_id' => 'self.id'}
);
__PACKAGE__ -> has_many(
    arrivals   => 'ClubSpain::Schema::Result::TimeTable', {'foreign.arrival_terminal_id' => 'self.id'}
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $self -> SUPER::sqlt_deploy_hook( $sqlt_table );
    $sqlt_table -> add_index(
        name => 'on_is_published',
        fields => ['is_published']
    );
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::Terminal

=head1 DESCRIPTION

Модель таблицы terminal - терминал аэропорта

=head1 FIELDS

=head2 id

Идентификатор терминала

=head2 airport_id

Идентификатор аэропорта

=head2 name

Название терминала

=head2 is_published

Флаг опубликованности терминала аэропорта

=head1 METHODS

=head2 departures()

Получение списка расписаний рейсов на отправлении из терминала

=head2 arrivals()

Получение списка расписаний рейсов на прибытие в терминал

=head1 SEE ALSO

L<ClubSpain::Schema::Result::TimeTable>
L<DBix::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut