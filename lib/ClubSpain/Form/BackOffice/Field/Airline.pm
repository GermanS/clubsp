package ClubSpain::Form::BackOffice::Field::Airline;
use strict;
use warnings;
use Moose::Role;

sub options_airline_id {
    my $self = shift;

    my @options;
    my $iterator = $self->model_object->schema->resultset('Airline')->search({});
    while (my $object = $iterator->next) {
        push @options, { value => $object->id, label => $object->name };
    }

    return \@options;
}

1;
