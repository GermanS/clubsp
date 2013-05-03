package ClubSpain::Controller::BackOffice::Manufacturer;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

has 'template'
    => ( is => 'ro', default => 'backoffice/manufacturer/manufacturer.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/manufacturer/manufacturer_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'manufacturer' );

use ClubSpain::Form::BackOffice::Manufacturer;
sub form :Private {
    my ($self, $listener) = @_;

    my $form = ClubSpain::Form::BackOffice::Manufacturer -> new();
    $form -> add_listener($listener);

    return $form;
}

sub default :Path {
    my ($self, $c) = @_;
    $c -> detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('manufacturer') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $manufacturer = $c -> model($self -> model) -> new();
    my $form = $self -> form($manufacturer);

    $form -> process($c -> request -> parameters);
    if ($form -> validated) {
        eval { $manufacturer -> create(); };
        $form -> process_error($@) if $@;
    }

    $c -> stash(
        form     => $form,
        template => $self -> template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $manufacturer = $c -> model($self -> model) -> new();
    my $form = $self -> form($manufacturer);
    $form -> process(
        init_object => {
            name    => $self -> get_object($c) -> name,
            code    => $self -> get_object($c) -> code
        },
        params => $c -> request -> parameters
    );

    if ($form -> validated) {
        $manufacturer -> set_id(
            $self -> get_object($c) -> id
        );

        eval { $manufacturer -> update(); };
        $form -> process_error($@) if $@;
    }

    $c -> stash(
        form     => $form,
        template => $self -> template_form
    );
};

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__