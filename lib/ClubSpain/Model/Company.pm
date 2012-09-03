package ClubSpain::Model::Company;
use Moose;
use utf8;
use namespace::autoclean;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Company' });

has 'id'            => ( is => 'rw' );
has 'zipcode'       => ( is => 'rw' );
has 'street'        => ( is => 'rw' );
has 'company'       => ( is => 'rw' );
has 'nick'          => ( is => 'rw' );
has 'website'       => ( is => 'rw' );
has 'INN'           => ( is => 'rw' );
has 'OKPO'          => ( is => 'rw' );
has 'OKVED'         => ( is => 'rw' );
has 'is_NDS'        => ( is => 'rw' );
has 'is_published'  => ( is => 'rw' );

with 'ClubSpain::Model::Role::Company';

sub validate_zipcode {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('zipcode')->type_constraint->validate($value);
}
sub validate_street  {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('street')->type_constraint->validate($value);
}
sub validate_company {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('company')->type_constraint->validate($value);
}
sub validate_nick {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('nick')->type_constraint->validate($value);
}
sub validate_website {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('website')->type_constraint->validate($value);
}
sub validate_INN  {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('INN')->type_constraint->validate($value);
}
sub validate_OKPO {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('OKPO')->type_constraint->validate($value);
}
sub validate_OKVED {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('OKVED')->type_constraint->validate($value);
}
sub validate_is_NDS  {
    my $self = shift;
    my $value = shift;
    $self->meta()->get_attribute('is_NDS')->type_constraint->validate($value);
}

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        id      => $self->id,
        zipcode => $self->zipcode,
        street  => $self->street,
        company => $self->company,
        nick    => $self->nick,
        website => $self->website,
        INN     => $self->INN,
        OKPO    => $self->OKPO,
        OKVED   => $self->OKVED,
        is_NDS  => $self->is_NDS,
        is_published => $self->is_published
    };
}


__PACKAGE__->meta->make_immutable();

1;
