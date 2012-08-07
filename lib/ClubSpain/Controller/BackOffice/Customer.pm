package ClubSpain::Controller::BackOffice::Customer;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Customer;
sub form :Private {
    my ($self, $model) = @_;
    return ClubSpain::Form::BackOffice::Customer->new( model_object => $model );
};

has 'template' => (
    is => 'ro',
    default => 'backoffice/customer/customer.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/customer/customer_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Customer',
);

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
        eval {
            $customer->id( $self->get_object($c)->id );
            $customer->is_published( $self->get_object($c)->is_published );
            $customer->update();
        };

        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};


=head

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/customer/customer.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Customer')->search({})
    );
};

sub base :Chained('/backoffice/base') :PathPart('customer') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $customer;
    eval {
        $customer = $c->model('Customer')->fetch_by_id($id);
        $c->stash( customer => $customer );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'customer'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'customer'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Customer')->delete($c->stash->{'customer'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('default'));
};

sub load_add_form :Private  {
    my ($self, $c) = @_;

    my $form = $self->form();
    $form->load_config_filestem('backoffice/customer_form');
    $form->process();

    return $form;
};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form => $self->load_add_form($c),
        template => 'backoffice/customer/customer_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $customer = $c->model('Customer')->new(
            name         => $c->request->param('name'),
            middlename   => $c->request->param('middlename'),
            surname      => $c->request->param('surname'),
            email        => $c->request->param('email'),
            passwd       => $c->request->param('passwd'),
            mobile       => $c->request->param('mobile'),
            is_published => ENABLE,
        );
        $customer->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $customer = $c->stash->{'customer'};

    $form->get_element({ name => 'name' })
            ->value($customer->name);
    $form->get_element({ name => 'middlename' })
            ->value($customer->middlename);
    $form->get_element({ name => 'surname' })
            ->value($customer->surname);
    $form->get_element({ name => 'email' })
            ->value($customer->email);
    $form->get_element({ name => 'passwd' })
            ->value($customer->passwd);
    $form->get_element({ name => 'mobile' })
            ->value($customer->mobile);
    $form->process;

    return $form;
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        form => $self->load_upd_form($c),
        template => 'backoffice/customer/customer_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $customer = $c->model('Customer')->new(
            id           => $c->stash->{'customer'}->id,
            name         => $c->request->param('name'),
            middlename   => $c->request->param('middlename'),
            surname      => $c->request->param('surname'),
            email        => $c->request->param('email'),
            passwd       => $c->request->param('passwd'),
            mobile       => $c->request->param('mobile'),
            is_published => $c->stash->{'customer'}->is_published,
        );
        $customer->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

=cut

__PACKAGE__->meta->make_immutable();

1;
