package ClubSpain::Model::Base;

use Moose;
use namespace::autoclean;
use utf8;

use MooseX::ClassAttribute;
class_has 'source_name' => ( is => 'ro', default => undef );

use Scalar::Util qw(blessed);

use ClubSpain::Exception;
use ClubSpain::Storage;
use ClubSpain::Constants qw(:all);

sub schema {
    return ClubSpain::Storage->instance()->schema();
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->get_id
        if (ref $self && !$id);

    my $object = $self->resultset()
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find " . $self->source_name . ": $id!")
        unless $object;

    return $object;
}

sub search {
    my ($self, $params, $cond) = @_;
    return unless $params;

    my $iterator = $self->resultset()
                        ->search($params, $cond);

    return $iterator;
}

sub create {
    my ($self, $params) = @_;

    $self->resultset()->create($params);
}

sub update {
    my ($self, $params) = @_;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;

    return $self->fetch_by_id()->update($params);
}

sub delete {
    my ($self, $id) = @_;

    return $self->fetch_by_id($id)->delete();
}

sub check_for_class_method {
    my $self = shift;

    throw ClubSpain::Exception::Argument(message => 'NOT A CLASS METHOD')
        unless blessed $self;
}

sub resultset {
    my $self = shift;

    return $self->schema()->resultset($self->source_name);
}

sub result_source {
    my $self = shift;

    return $self->schema()->resultset($self->source_name)->result_source();
}

sub set_enable {
    my $self = shift;

    $self->set_is_published(ENABLE);
}

sub set_disable {
    my $self = shift;

    $self->set_is_published(DISABLE);
}

__PACKAGE__->meta->make_immutable();

1;
