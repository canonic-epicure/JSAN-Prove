use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'JSAN::Prove' }
BEGIN { use_ok 'JSAN::Prove::Controller::Local' }

ok( request('/local')->is_success, 'Request should succeed' );


