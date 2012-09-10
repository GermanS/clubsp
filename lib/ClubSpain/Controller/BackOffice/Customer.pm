package ClubSpain::Controller::BackOffice::Customer;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Customer;
sub form :Private {
    my ($self, $listener) = @_;
    return ClubSpain::Form::BackOffice::Customer->new({
        listeners => [ $listener ]
    });
};

has 'template'
    => ( is => 'ro', default => 'backoffice/customer/customer.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/customer/customer_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'Customer' );

sub default :Path {
    my ($self, $c) = @_;
    $c->stash( iterator => $c->model($self->model)->search({}) );
};

sub base :Chained('/backoffice/base') :PathPart('customer') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $customer = $c->model($self->model)->new();
    my $form = $self->form($customer);

    $form->process($c->request->parameters);
    if ($form->validated) {
        $customer->set_enable();

        eval { $customer->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $customer = $c->model($self->model)->new();
    my $form = $self->form($customer);
    $form->process(
        init_object => {
            name    => $self->get_object($c)->name,
            surname => $self->get_object($c)->surname,
            email   => $self->get_object($c)->email,
            passwd  => $self->get_object($c)->passwd,
            mobile  => $self->get_object($c)->mobile,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $customer->set_id(
            $self->get_object($c)->id
        );
        $customer->set_is_published(
            $self->get_object($c)->is_published
        );

        eval { $customer->update(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};


__PACKAGE__->meta->make_immutable();

1;
