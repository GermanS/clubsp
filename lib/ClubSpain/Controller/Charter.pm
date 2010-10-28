package ClubSpain::Controller::Charter;

use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);

sub index :Path {
    my ($self, $c) = @_;

    $self->load_charter_search_form($c);

    $c->stash(template => 'charter/search.tt2');
}

sub load_charter_search_form {
    my ($self, $c) = @_;

    my $form = $self->form();
    $form->load_config_filestem('charter_search');
    $form->process();

    $c->stash->{form} = $form;
}


=head2 info()

Обработка запроса http://example.com/charter/info
необходимо показать общую информацию о воздушной перевозке и провозе багажа

=cut

sub info :Local {
    my ($self, $c) = @_;

    $c->forward( $c->view('TT::Charter::Info') );
}

sub end : ActionClass('RenderView') {}

1;
