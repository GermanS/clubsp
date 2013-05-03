package ClubSpain::Controller::BackOffice::Airplane;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::Airplane;
sub form :Private {
    my ($self, $listener) = @_;

    return ClubSpain::Form::BackOffice::Airplane -> new({
        listeners => [ $listener ]
    });
}

has 'template'
    => ( is => 'ro', default => 'backoffice/airplane/airplane.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/airplane/airplane_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'Airplane' );

sub auto :Private {
    my ($self, $c) = @_;

    $c -> stash(
        template => $self -> template(),
        manufacturer_list => $c -> model('Manufacturer') -> search({})
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c -> detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('airplane') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $plane = $c -> model( $self -> model ) -> new();
    my $form  = $self -> form($plane);
    $form -> process($c -> request -> parameters);

    if ($form -> validated) {
        $plane -> set_enable();

        eval { $plane -> create(); };
        $form -> process_error($@) if $@;
    }

    $c -> stash(
        form     => $form,
        template => $self -> template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $plane = $c -> model( $self -> model ) -> new();
    my $form = $self -> form($plane);
    $form -> process(
        init_object => {
            name => $self -> get_object($c) -> name,
            iata => $self -> get_object($c) -> iata,
            icao => $self -> get_object($c) -> icao,
            manufacturer_id => $self -> get_object($c) -> manufacturer_id,
        },
        params => $c -> request -> parameters
    );

    if ($form -> validated) {
        $plane -> set_id( $self -> get_object($c) -> id );
        $plane -> set_is_published( $self -> get_object($c) -> is_published );

        eval { $plane -> update(); };
        $form -> process_error($@) if $@;
    }

    $c -> stash(
        form     => $form,
        template => $self -> template_form
    );
};

sub browse :Local :Args(1) {
    my ($self, $c, $manufacturer) = @_;

    $c -> stash(
        iterator => $c -> model($self -> model) -> search({
            manufacturer_id => $manufacturer
        })
    );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__