use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Language');
use_ok('ClubSpain::XML::Olympia::Response::Language');

my @expect = map new ClubSpain::XML::Olympia::Language($_),
    { Codigo => "01", Descripcion => "Spanish" },
    { Codigo => "02", Descripcion => "English" },
    { Codigo => "03", Descripcion => "French" },
    { Codigo => "04", Descripcion => "Portuguese" },
    { Codigo => "05", Descripcion => "Russian" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Language->parse($response);

is_deeply($result, \@expect, 'returned languages');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Idiomas>
      <Idioma>
        <Codigo>01</Codigo>
        <Descripcion>Spanish</Descripcion>
      </Idioma>
      <Idioma>
        <Codigo>02</Codigo>
        <Descripcion>English</Descripcion>
      </Idioma>
      <Idioma>
        <Codigo>03</Codigo>
        <Descripcion>French</Descripcion>
      </Idioma>
      <Idioma>
        <Codigo>04</Codigo>
        <Descripcion>Portuguese</Descripcion>
      </Idioma>
      <Idioma>
        <Codigo>05</Codigo>
        <Descripcion>Russian</Descripcion>
      </Idioma>
    </Idiomas>
  </Respuesta>
</string>


}
