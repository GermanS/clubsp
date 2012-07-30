package ClubSpain::Controller::BackOffice::Terminal;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Terminal;
sub form :Private {
    my ($self, $model) = @_;
    return ClubSpain::Form::BackOffice::Terminal->new( model_object => $model );
}

has 'template' => (
    is => 'ro',
    default => 'backoffice/terminal/terminal.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/terminal/terminal_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Terminal',
);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template     => $self->template,
        airport_list => $c->model('Airport')->search({})
    );
};

sub default :Path {
    my ($self, $c) = @_;
    $c->stash( iterator => $c->model($self->model)->search({}) );
};

sub base :Chained('/backoffice/base') :PathPart('terminal') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $term = $c->model($self->model)->new();
    my $form = $self->form($term);
    $form->process($c->request->parameters);

    if ($form->validated) {
        $term->set_enable();

        eval { $term->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $term = $c->model($self->model)->new();
    my $form = $self->form($term);
    $form->process(
        init_object => {
            airport_id  => $self->get_object($c)->airport_id,
            name        => $self->get_object($c)->name,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            $term->id( $self->get_object($c)->id );
            $term->is_published( $self->get_object($c)->is_published );
            $term->update();
        };

        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

sub browse :Local :Args(1) {
    my ($self, $c, $airport) = @_;

    $c->stash(
        iterator => $c->model('Terminal')->search({ airport_id => $airport })
    );
}

__PACKAGE__->meta->make_immutable();

1;
