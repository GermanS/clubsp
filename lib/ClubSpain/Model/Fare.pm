package ClubSpain::Model::Fare;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Fare' });

has 'id'            => ( is => 'ro' );
has 'is_published'  => ( is => 'ro', required => 1 );
has 'fare'         => ( is => 'ro', required => 1 );

#has 'segments'      => { is => 'ro', required => 1, isa => 'ArreyRef' };

1;
