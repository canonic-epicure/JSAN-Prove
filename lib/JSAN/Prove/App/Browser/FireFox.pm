package JSAN::Prove::App::Browser::FireFox;

use Moose;
extends 'JSAN::Prove::App::Browser';


#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub get_exe_path {
	my ($self, $url) = @_;
	return "firefox -new-window $url";
}


#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub is_startable {
	my ($self) = @_;
	
	return 1;
}


1;