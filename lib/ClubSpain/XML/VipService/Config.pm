package ClubSpain::XML::VipService::Config;
use namespace::autoclean;
use Moose;

has 'locale'              => ( is => 'ro', required => 1 );
has 'loginName'           => ( is => 'ro', required => 1 );
has 'password'            => ( is => 'ro', required => 1 );
has 'salesPointCode'      => ( is => 'ro', required => 1 );
has 'corporateClientCode' => ( is => 'ro', required => 1 );
has 'wsdlfile' => ( is => 'ro', required => 1 );
has 'xsdfile'  => ( is => 'ro', required => 1 );

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
        corporateClientCode => $self->corporateClientCode
    };
}


__PACKAGE__->meta->make_immutable();

1;
