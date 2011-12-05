package ClubSpain::XML::VipService::Config;
use namespace::autoclean;
use Moose;

has 'locale'              => ( is => 'ro', required => 1 );
has 'loginName'           => ( is => 'ro', required => 1 );
has 'password'            => ( is => 'ro', required => 1 );
has 'salesPointCode'      => ( is => 'ro', required => 1 );
#has 'corporateClientCode' => ( is => 'ro', required => 1 );
has 'wsdlfile' => ( is => 'ro', required => 1 );
has 'xsdfile'  => ( is => 'ro', required => 1 );

#main catalust configuration
has 'config' => ( is => 'ro' );

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    my %args  = ( @_ == 1 ? %{ $_[0] } : @_ );

    if ($args{'config'} && $args{'config'}->{'XML::VipService::Config'}) {
        my $config = $args{'config'}->{'XML::VipService::Config'};
        $args{'locale'} = $config->{'locale'}
            unless $args{'locale'};

        $args{'loginName'} = $config->{'loginName'}
            unless $args{'loginName'};

        $args{'password'} = $config->{'password'}
            unless $args{'password'};

        $args{'salesPointCode'} = $config->{'salesPointCode'}
            unless $args{'salesPointCode'};

#        $args{'corporateClientCode'} = $config->{'corporateClientCode'}
#            unless $args{'corporateClientCode'};

        $args{'wsdlfile'} = $config->{'wsdlfile'}
            unless $args{'wsdlfile'};

        $args{'xsdfile'} = $config->{'xsdfile'}
            unless $args{'xsdfile'};
    }

    return $class->$orig(%args);
};

=head2 _context_hash()

  Полученение хеша аттрибутов агентства для доступа к системе
  бронирования авиабилетов

=cut

sub to_hash {
    my $self = shift;

    return  {
        locale         => $self->locale,
        loginName      => $self->loginName,
        password       => $self->password,
        salesPointCode => $self->salesPointCode,
#        corporateClientCode => $self->corporateClientCode
    };
}


__PACKAGE__->meta->make_immutable();

1;
