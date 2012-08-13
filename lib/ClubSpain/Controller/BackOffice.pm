package ClubSpain::Controller::BackOffice;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
use ClubSpain::Form::BackOffice::Signin;

# base sub for matching public path /account
# -- this verifies logged-in-ness for everything chained onto it
sub base :Chained("/") :PathPart('backoffice') :CaptureArgs(0) {
}

sub auto :Private {
    my ($self, $c) = @_;

    if($c->user_exists && $c->user) {
        $c->stash(
            profile  => $c->user->obj(),
        );
    } else {
        $c->detach('root');
    }

    return 1;
}

# display /backoffice page
sub root :Chained("base") :PathPart("") :Args(0) {
    my ($self, $c) = @_;

    unless ($c->stash->{'profile'}) {
        my $form = ClubSpain::Form::BackOffice::Signin->new();
        $form->process( params => $c->request->parameters );

        if ($form->validated &&
            $c->authenticate({ email    => $c->request->param('email'),
                               password => $c->request->param('password') })) {
            $c->stash(
                profile  => $c->user->obj(),
                template => 'backoffice/index.tt2'
            );
        } else {
            $c->stash(
                form     => $form,
                template => 'backoffice/signin.tt2'
            );
        }
    }
}

__PACKAGE__->meta->make_immutable();

1;
