use Test::More;
use strict;
use warnings;
use utf8;
use Template;
use DateTime;

use lib qw(t/lib);
use ClubSpain::Test;

my @tests = qw(calendar_months.tt2
               calendar_header.tt2);
plan tests => scalar @tests;


my $params = {
    start => DateTime->new(year => 2011, month => 6, day => 1 ),
    end   => DateTime->new(year => 2012, month => 1, day => 1 )
};

my $tt = Template->new({ENCODING => 'utf8'}) || die "Error creating Template";
my $docroot = 't/htdocs/tt2';
my $output  = '';

foreach my $test (@tests) {
    diag ("The test : $test");
    my $output = '';
    $tt->process("$docroot/$test", $params, \$output);

    my ($ok, $response, $file) = ClubSpain::Test->comp_to_file($output, "$docroot/out/$test.out");

    if (!$ok) {
        diag("Test: $test");
        diag("Error:\n" . $tt->error ) if $tt->error;
        diag("Expected:\n". $file);
        diag("Received:\n". $response);
    }

    ok($ok, "$test was successful");
}
