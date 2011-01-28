package ClubSpain::Model::Base;

use Moose;
use namespace::autoclean;

use MooseX::ClassAttribute;
class_has 'source_name' => ( is => 'ro', default => undef );

use Scalar::Util qw(blessed);

use ClubSpain::Exception;
use ClubSpain::Storage;

sub schema {
    return ClubSpain::Storage->instance()->schema();
}

sub fetch_by_id {
    my ($self, $id) = @_;

    $id = $self->id
        if (ref $self && !$id);

    my $object = $self->schema
                      ->resultset($self->source_name)
                      ->find({ id => $id }, { key => 'primary' });

    throw ClubSpain::Exception::Storage(message => "Couldn't find " . $self->source_name . ": $id!")
        unless $object;

    return $object;
}

sub list {
    my ($self, $params, $cond) = @_;
    return unless $params;

    my $iterator = $self->schema
                        ->resultset($self->source_name)
                        ->search($params, $cond);

    return $iterator;
}

sub create {
    my ($self, $params) = @_;

    $self->schema->resultset($self->source_name)->create($params);
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

__PACKAGE__->meta->make_immutable();

1;
