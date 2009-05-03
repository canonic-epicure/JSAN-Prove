package JSAN::Prove::App;

use Module::Pluggable sub_name => 'available_browsers', search_path => [ 'JSAN::Prove::App::Browser' ], require => 1;

use Moose;

has 'browsers' => ( is => 'rw' );

 
#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub start_browsers {
	my ($self, $url) = @_;
	
	my @startable_browsers = grep { $_->is_startable } $self->available_browsers();
	
	my $browsers = {};
	foreach my $class ( @startable_browsers ) {
		$class =~ m/JSAN::Prove::App::Browser::(.+)/; 
		$browsers->{$1} = $class->new;
		die "Startable browser [$class] failed to start" unless $browsers->{$1}->start($url . "/prove/$1");
	};
	
	die "No browsers were able to start on this platform" unless keys(%{$self->browsers}); 
}


#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub stop_browser {
	my ($self, $browser) = @_;
	
	$self->browsers->{$browser}->stop();
}


#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub is_running {
	my ($self) = @_;
	
	my $running = 0;
	foreach (values(%{$self->browsers})) {
		$running = 1 if $_->is_alive;
	}
	
	return $running;
}


1;