package ClubSpain::Controller::BackOffice::Company;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Company;
sub form :Private {
    my ($self, $listener) = @_;

    my $form = ClubSpain::Form::BackOffice::Company->new();
    $form->add_listener($listener);

    return $form;
};

has 'template' => (
    is      => 'ro',
    default => 'backoffice/company/company.tt2'
);

has 'template_form' => (
    is      => 'ro',
    default => 'backoffice/company/company_form.tt2'
);

has 'model' => (
    is      => 'ro',
    default => 'Company',
);

sub default :Path {
    my ($self, $c) = @_;
    $c->detach('page');
}

sub base :Chained('/backoffice/base') :PathPart('company') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $company = $c->model($self->model)->new();
    my $form    = $self->form($company);
    $form->process($c->request->parameters);

    if ($form->validated) {
        $company->set_enable();

        eval { $company->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $company = $c->model($self->model)->new();
    my $form = $self->form($company);
    $form->process(
        init_object => {
            legal_index   => $self->get_object($c)->zipcode,
            legal_address => $self->get_object($c)->street,
            company       => $self->get_object($c)->company,
            nick          => $self->get_object($c)->nick,
            website       => $self->get_object($c)->website,
            INN           => $self->get_object($c)->INN,
            OKPO          => $self->get_object($c)->OKPO,
            OKVED         => $self->get_object($c)->OKVED,
            is_NDS        => $self->get_object($c)->is_NDS,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $company->id( $self->get_object($c)->id );
        $company->is_published( $self->get_object($c)->is_published );

        eval { $company->update(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

__PACKAGE__->meta->make_immutable();

1;
