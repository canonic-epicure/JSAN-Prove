use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'JSAN::Prove', 'JSAN::Prove::App' }

ok( request('/')->is_success, 'Request should succeed' );


#================================================================================================================================================================================================================================================
my $app = JSAN::Prove::App->new;

ok($app, 'App instance was created');