package ClubSpain::Form::BackOffice::Field::Airplane;
use strict;
use warnings;
use utf8;
use Moose::Role;

sub options_airplane_id {
    my $self = shift;

    my @options;
    my $iterator = $self->model_object->schema->resultset('Airplane')->search({});
    while (my $object = $iterator->next) {
        push @options, { value => $object->id, label => $object->name };
    }

    return \@options;
}

1;
