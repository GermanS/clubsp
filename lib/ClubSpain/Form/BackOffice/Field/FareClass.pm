package ClubSpain::Form::BackOffice::Field::FareClass;
use strict;
use warnings;
use Moose::Role;

sub options_fare_class_id {
    my $self = shift;

    my @options;
    my $iterator = $self->model_object->schema->resultset('FareClass')->search({});
    while (my $object = $iterator->next) {
        push @options, { value => $object->id, label => $object->name };
    }

    return \@options;
}

1;