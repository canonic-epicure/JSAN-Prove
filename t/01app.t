use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More tests => 5;

BEGIN { use_ok 'Catalyst::Test', 'JSAN::Prove', 'JSAN::Prove::App' }

#================================================================================================================================================================================================================================================
diag('Web-server');

ok( request('/')->is_success, 'Request should succeed' );



#================================================================================================================================================================================================================================================
diag('Application creation & browsers starting');

my $app = JSAN::Prove::App->new;

ok($app, 'App instance was created');

$app->start_browsers('http://yandex.ru');

sleep(2);

ok($app->is_running, 'At least one browser started');

sleep(2);


#================================================================================================================================================================================================================================================
diag('Browsers stopping');

my @browsers = keys(%{$app->browsers});

foreach my $browser (@browsers) {
	$app->stop_browser($browser);
}

ok(!$app->is_running, 'All browsers closed');