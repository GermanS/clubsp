package ClubSpain::Controller::BackOffice::BaseRole;
use strict;
use warnings;
use utf8;

use ClubSpain::Constants qw(:all);
use ClubSpain::Message;

use Data::Page;
use Data::Page::FlickrLike;

use MooseX::MethodAttributes::Role;

sub auto :Private {
    my ($self, $c) = @_;

    $c -> stash(template => $self -> template);
};


sub end :ActionClass('RenderView') {};


sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $self -> get_object($c) -> update({
        is_published => ENABLE
    });
    $c -> detach('default');
};


sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $self -> get_object($c) -> update({
        is_published => DISABLE
    });
    $c -> detach('default');
};


sub get_object :Private  {
    my ($self, $c) = @_;

    return $c -> stash -> {'object'};
};


sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $object;
    eval {
        $object = $c -> model($self -> model) -> fetch_by_id($id);
        $c -> stash( object => $object );
    };

    if ($@) {
        $self -> show_message(context => $c, error => $@);
        $c -> detach('default');
    }
};


sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval { $c -> model($self -> model) -> delete( $self -> get_object($c) -> id ); };
    $self -> show_message(context => $c, error => $@);

    $c -> detach('default');
};

#показать ошибки при работе с данными вне формы
sub show_message :Private {
    my ($self, %params) = @_;

    $params{'error'} ? $self -> show_error_message(%params)
                     : $self -> show_successful_message(%params);
};

sub show_error_message :Private {
    my ($self, %params) = @_;


    if ($params{'error'} = Exception::Class -> caught('ClubSpain::Exception::Validation')) {
        $params{'сontext'} -> stash( message => ClubSpain::Message -> warning( $params{'error'} -> message ) );
    } elsif ($params{'error'} = Exception::Class -> caught('ClubSpain::Exception::Storage')) {
        $params{'context'} -> stash( message => ClubSpain::Message -> error( $params{'error'} -> message ));
    } else {
        $params{'context'} -> stash( message => ClubSpain::Message -> error( $@ ) );
    }

};

sub show_successful_message :Private {
    my ($self, %params) = @_;

    $params{'context'} -> stash( message => ClubSpain::Message -> ok( MESSAGE_OK ) );
};

sub page :Local :CaptureArgs(1) {
    my ($self, $c, $page_num) = @_;

    $page_num = 1 unless $page_num;
    my $iterator = $c -> model($self -> model) -> search({}, {
        rows => 50,
        page => $page_num,
    });
    $c -> stash( iterator => $iterator );

    my $total = $c -> model($self -> model) -> search({}) -> count();
    $self -> make_pager($c, $total, $page_num);
}

sub make_pager :Private {
    my ($self, $c, $total, $page_num) = @_;

    #put it into config
    my $limit    = 50;
    my $offset   = $limit * ( $page_num - 1 );

    my $pager = Data::Page -> new();
    $pager -> total_entries($total);
    $pager -> entries_per_page($limit);
    $pager -> current_page($page_num);

    $c -> stash() -> {'pager'} = $pager;

    return ($limit, $offset);
}

1;
