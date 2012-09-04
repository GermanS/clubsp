package ClubSpain::Form::BackOffice::Field::City;
use strict;
use warnings;
use utf8;
use Moose::Role;

sub options_city_id {
    my $self = shift;

    my @options;
    my $iterator = $self->get_listener(0)->schema->resultset('City')->search({});
    while (my $object = $iterator->next) {
        push @options, { value => $object->id, label => $object->name };
    }

    return \@options;
}

1;
