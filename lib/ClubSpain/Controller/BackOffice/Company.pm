package ClubSpain::Controller::BackOffice::Company;
use strict;
use warnings;
use utf8;
#use parent qw(ClubSpain::Controller::BackOffice::FormFu);
use parent qw(Catalyst::Controller);
use ClubSpain::Constants qw(:all);
use ClubSpain::Form::BackOffice::Company;

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/company/company.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Company')->search({})
    );
};

sub base :Chained('/backoffice/base') :PathPart('Company') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $company;
    eval {
        $company = $c->model('Company')->fetch_by_id($id);
        $c->stash( company => $company );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'Company'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'Company'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Company')->delete($c->stash->{'Company'}->id);
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

    my $form = ClubSpain::Form::BackOffice::Company->new( ctx => $c );


#    my $form = $self->form();
#    $form->load_config_filestem('backoffice/company_form');
#    $form->process();

    return $form;
};

sub create :Local {
    my ($self, $c) = @_;

#    my $form = $self->load_add_form($c);
#    if ($form->submitted_and_valid()) {
#        $self->insert($c);
#    }

    $c->stash(
        form => $self->load_add_form($c),
        template => 'backoffice/company/company_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $company = $c->model('Company')->new(
            name => $c->request->param('name'),
            nick => $c->request->param('nick'),
            INN  => $c->request->param('INN'),
            OGRN => $c->request->param('OGRN'),
            KPP  => $c->request->param('KPP'),
            OKPO => $c->request->param('OKPO'),
            OKVED=> $c->request->param('OKVED'),
            OKATO=> $c->request->param('OKATO'),
            OKTMO=> $c->request->param('OKTMO'),
            OKOGU=> $c->request->param('OKOGU'),
            OKFS => $c->request->param('OKFS'),
            OKPF => $c->request->param('OKPF'),
            is_published => ENABLE,
        );
        $company->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $company = $c->stash->{'Company'};

    my @fields = qw(name nick INN OGRN KPP OKPO OKVED OKATO OKTMO OKOGU OKFS OKPF);
    for my $field (@fields) {
        $form->get_element({ name => $field })->value($company->$field);
    }
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
        template => 'backoffice/company/company_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $company = $c->model('Company')->new(
            id           => $c->stash->{'Company'}->id,
            name => $c->request->param('name'),
            nick => $c->request->param('nick'),
            INN  => $c->request->param('INN'),
            OGRN => $c->request->param('OGRN'),
            KPP  => $c->request->param('KPP'),
            OKPO => $c->request->param('OKPO'),
            OKVED=> $c->request->param('OKVED'),
            OKATO=> $c->request->param('OKATO'),
            OKTMO=> $c->request->param('OKTMO'),
            OKOGU=> $c->request->param('OKOGU'),
            OKFS => $c->request->param('OKFS'),
            OKPF => $c->request->param('OKPF'),
            is_published => $c->stash->{'Company'}->is_published,
        );
        $company->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

1;
