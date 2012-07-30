package ClubSpain::Form::BackOffice::Field::Country;
use strict;
use warnings;
use Moose::Role;

sub options_country_id {
    my $self = shift;

    my @options;
    my $iterator = $self->model_object->schema->resultset('Country')->search({});
    while (my $object = $iterator->next) {
        push @options, { value => $object->id, label => $object->name };
    }

    return \@options;
}

1;
