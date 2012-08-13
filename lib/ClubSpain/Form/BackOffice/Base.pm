package ClubSpain::Form::BackOffice::Base;
use strict;
use warnings;
use namespace::autoclean;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
with 'HTML::FormHandler::Widget::Theme::Bootstrap';

use ClubSpain::Exception;

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
