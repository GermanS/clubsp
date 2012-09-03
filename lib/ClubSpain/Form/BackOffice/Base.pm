package ClubSpain::Form::BackOffice::Base;
use strict;
use warnings;
use utf8;
use namespace::autoclean;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
    with 'HTML::FormHandler::Widget::Theme::Bootstrap';

use ClubSpain::Exception;

has 'listeners' => (
    is      => 'rw',
    isa     => 'ArrayRef',
    default => sub { [] },
    traits  => ['Array'],
    handles => {
        all_listeners => 'elements',
        add_listener  => 'push',
    }
);

sub check_field {
    my $self = shift;
    my $method = shift;
    my $field = shift;

    for my $listener ($self->all_listeners) {
        if ( $listener->can($method) ) {
            eval {
                $listener->$method($field->value)
            };
            if ($@) {
                $self->process_validation_error($field);
            }
        }
    }
}

after 'validate' => sub {
    my $self = shift;
    return unless $self->is_valid();

    foreach my $listener ($self->all_listeners) {
        $listener->notify($self);
    }
};

#обработка ошибок применимых к целой форме
sub process_error {
    my ($self, $exception) = @_;

    if ($exception = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $self->push_form_errors( $exception->message   );
    } elsif ($exception = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $self->push_form_errors(  $exception->message  );
    } elsif ($exception = Exception::Class->caught('DBIx::Class::Exception')) {
        $self->push_form_errors(  $exception->{'msg'}  );
    } else {
        $self->push_form_errors( scalar($exception)  );
    }
}

#обработка ошибок валидации полей формы
sub process_validation_error {
    my ($self, $field) = @_;

    if (my $e = ClubSpain::Exception::Validation->caught()) {
        $field->add_error($e->message);
    } else {
        $field->add_error(ClubSpain::Exception::Base->new()->description);
    }
}

no HTML::FormHandler::Moose;

1;
