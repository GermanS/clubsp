use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::Service');

my $expected = &request();
my $content = ClubSpain::XML::Olympia::Request::Service->request(
    user      => 7777,
    password  => 8888,
    codigo_proveedor => 'CS009003',
    fecha_inicial => '2008/05/10',
    fecha_final   => '2008/05/25',
);
is($content, $expected, 'check content');

sub request {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<DevuelveServicios xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
  <CodigoProveedor>CS009003</CodigoProveedor>
  <FechaInicial>2008/05/10</FechaInicial>
  <FechaFinal>2008/05/25</FechaFinal>
  <IdMercado/>
</DevuelveServicios>


}

