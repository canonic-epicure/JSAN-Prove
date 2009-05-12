package JSAN::Prove::App;

use Module::Pluggable sub_name => 'available_browsers', search_path => [ 'JSAN::Prove::App::Browser' ], require => 1;

use Moose;

has 'browsers' => ( is => 'rw' );

 
#================================================================================================================================================================================================================================================
sub start_browsers {
	my ($self, $url) = @_;
	
	my @startable_browsers = grep { $_->is_startable } $self->available_browsers();
	
	my $browsers = {};
	foreach my $class ( @startable_browsers ) {
		$class =~ m/JSAN::Prove::App::Browser::(.+)/; 
		$browsers->{$1} = $class->new;
		die "Startable browser [$class] failed to start" unless $browsers->{$1}->start($url . "/local/t/index.html?browser=$1");
	};
	
	$self->browsers($browsers);
	
	die "No browsers were able to start on this platform" unless keys(%$browsers); 
}


#================================================================================================================================================================================================================================================
sub stop_browser {
	my ($self, $browser) = @_;
	
	$self->browsers->{$browser}->stop();
}


#================================================================================================================================================================================================================================================
sub is_running {
	my ($self) = @_;
	
	foreach (values(%{$self->browsers})) {
		return 1 if $_->is_alive;
	}
	
	return 0;
}


1;