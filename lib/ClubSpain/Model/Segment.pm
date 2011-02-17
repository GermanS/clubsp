package ClubSpain::Model::Segment;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Segment' });

has 'timetable_id'  => ( is => 'ro', required => 1 );
has 'fare_class_id' => ( is => 'ro', required => 1 );
has 'fare_id'       => ( is => 'ro', required => 1 );

1;
