package ClubSpain::Form::BackOffice::Field::Article;
use strict;
use warnings;
use utf8;
use Moose::Role;

sub options_parent_id {
    my $self = shift;

    my $tree = $self->model_object->tree();
    return make_options($tree);

    sub make_options {
        my $tree = shift;
        my $level = shift || 0;
        my @options = ();

        foreach my $option (@$tree) {
            push @options, {
                value => $option->{'value'},
                label => sprintf "%s %s", '--' x $level, $option->{'label'},
            };

            push @options, make_options($option->{'children'}, $level+1);
        }

        return @options;
    }
}

1;
