package ClubSpain::Controller::BackOffice::City;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
    with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Form::BackOffice::City;
sub form :Private {
    my ($self, $listener) = @_;
    return ClubSpain::Form::BackOffice::City -> new({
        listeners => [ $listener ]
    });
}

has 'template'
    => ( is => 'ro', default => 'backoffice/city/city.tt2' );
has 'template_form'
    => ( is => 'ro', default => 'backoffice/city/city_form.tt2' );
has 'model'
    => ( is => 'ro', default => 'City' );

sub auto :Private {
    my ($self, $c) = @_;

    $c -> stash(
        template     => $self -> template,
        country_list => $c -> model('Country') -> search({})
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c -> detach('page');
};

sub base :Chained('/backoffice/base') :PathPart('city') :CaptureArgs(0) {};

sub create :Local {
    my ($self, $c) = @_;

    my $city = $c -> model($self -> model) -> new();
    my $form = $self -> form($city);
    $form -> process($c -> request -> parameters);

    if ($form -> validated) {
        $city -> set_enable();

        eval { $city -> create(); };
        $form -> process_error($@) if $@;
    }

    $c -> stash(
        form     => $form,
        template => $self -> template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $city = $c -> model($self -> model) -> new();
    my $form = $self -> form($city);
    $form -> process(
        init_object => {
            country_id  => $self -> get_object($c) -> country_id,
            name_en     => $self -> get_object($c) -> name,
            name_ru     => $self -> get_object($c) -> name_ru,
            iata        => $self -> get_object($c) -> iata,
        },
        params => $c -> request -> parameters
    );

    if ($form -> validated) {
        $city -> set_id(
            $self -> get_object($c) -> id
        );
        $city -> set_is_published(
            $self -> get_object($c) -> is_published
        );

        eval { $city -> update(); };
        $form -> process_error($@) if $@;
    }

    $c -> stash(
        form     => $form,
        template => $self -> template_form
    );
};

sub browse :Local :Args(1) {
    my ($self, $c, $country) = @_;

    $c -> stash(
        iterator => $c -> model('City') -> search({ country_id => $country })
    );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__