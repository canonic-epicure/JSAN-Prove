package JSAN::Prove::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

JSAN::Prove::Controller::Root - Root Controller for JSAN::Prove

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

use Data::Dump qw(dump);
use Path::Class;
use JSAN::Prove::App;

use Moose;

has 'is_passed' => ( is => 'rw', default => 1 );

has 'app' => (is => 'rw');


#================================================================================================================================================================================================================================================
sub index :Path {
	my ( $self, $c ) = @_;
	
	$c->response->body( 'index' );
}


#================================================================================================================================================================================================================================================
sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}


#================================================================================================================================================================================================================================================
sub proven :Local :Args(2) {
    my ( $self, $c, $browser, $result ) = @_;
	
	$self->{is_passed} &&= $result eq 'pass' ? 1 : 0;
	
	my $app = $self->app; 
	$app->stop_browser($browser);
	
	if ($app->is_running) {
		$c->response->body( $result );
	} else {
		exit($self->is_passed);
	}
}


#================================================================================================================================================================================================================================================
sub inc :Local {
    my ( $self, $c, @captures ) = @_;
	$c->serve_static_file(file($c->config->{'JSAN_LIB'}, 'lib', @captures));
}


#================================================================================================================================================================================================================================================
sub static :Local {
    my ( $self, $c, @captures ) = @_;
	$c->serve_static_file(file($c->config->{'JSAN_LIB'}, 'static', @captures));
}


#================================================================================================================================================================================================================================================
sub start :Local {
    my ( $self, $c ) = @_;
    
	my $url = $c->get_self_url;
	
	$self->app( JSAN::Prove::App->new );
	$self->app->start_browsers($url);
	
	$c->response->body('started');
}




=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

SamuraiJack

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
