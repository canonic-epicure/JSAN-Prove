package JSAN::Prove;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root 
#                 directory

use parent qw/Catalyst/;

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
/;

our $VERSION = '0.01';

# Configure the application. 
#
# Note that settings in jsan_prove.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

use Config;
use URI;
use lib "$ENV{HOME}/Workspace/EclipseWorkspace/JSAN/module-build-jsan/lib";
use Module::Build::JSAN;

__PACKAGE__->config(
#	title => $ENV{JSAN_PROVE_TITLE},
#	
#	urls => [ map { URI->new($_)->abs('/local/')->as_string() } split("\n", $ENV{JSAN_PROVE_TESTS} || '') ],

	JSAN_LIB => Module::Build::JSAN::get_jsan_libroot(),

    name => 'JSAN::Prove',
    
	'View::TT' => {
		CATALYST_VAR => 'Catalyst',
		INCLUDE_PATH => [        
			__PACKAGE__->path_to( 'root', 'tt' )
		],
	}
  
);


# Start the application
__PACKAGE__->setup();


#================================================================================================================================================================================================================================================
sub get_self_url {
	require Sys::Hostname;
        
    my $host = lc Sys::Hostname::hostname();
    my $port = $ENV{JSAN_PROVE_PORT};
        
	my $url = "http://$host";
	$url .= ":$port" unless $port == 80;
	
	return $url;
}


#================================================================================================================================================================================================================================================
#sub run {
#	my ($self, @args) = @_;
#	
##	unless (fork) {
##		sleep(1);
##		
##		my $start_url = $self->get_self_url . '/start';
##		
##		system ("lwp-request $start_url");
##	} else {
#		$self->SUPER::run(@args);
##	}
#}


=head1 NAME

JSAN::Prove - Catalyst based application

=head1 SYNOPSIS

    script/jsan_prove_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<JSAN::Prove::Controller::Root>, L<Catalyst>

=head1 AUTHOR

SamuraiJack

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
