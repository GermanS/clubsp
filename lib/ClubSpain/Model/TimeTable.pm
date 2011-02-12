package ClubSpain::Model::TimeTable;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'TimeTable' });

has 'id'                    => ( is => 'ro' );
has 'is_published'          => ( is => 'ro', required => 1 );
has 'flight_id'             => ( is => 'ro', required => 1 );
has 'departure_date'        => ( is => 'ro', required => 1 );
has 'departure_time'        => ( is => 'ro', required => 1 );
has 'arrival_date'          => ( is => 'ro', required => 1 );
has 'arrival_time'          => ( is => 'ro', required => 1 );
has 'airplane_id'           => ( is => 'ro' );
has 'departure_terminal_id' => ( is => 'ro' );
has 'arrival_terminal_id'   => ( is => 'ro' );

1;
