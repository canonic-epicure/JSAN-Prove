package JSAN::Prove::Controller::Local;

use strict;
use warnings;
use parent 'Catalyst::Controller';

use Path::Class;

#================================================================================================================================================================================================================================================
sub index :Path {
    my ( $self, $c, @captures ) = @_;
	$c->serve_static_file(file('.', @captures));
}


#================================================================================================================================================================================================================================================
#sub t : Local {
#    my ( $self, $c, @captures ) = @_;
#	
#	if (@captures == 1 && $captures[0] eq 'prove.html' && $c->req->params->{browser}) {
#		$c->stash->{title} = $c->config->{title};
#		$c->stash->{urls} = $c->config->{urls};
#		$c->stash->{browser} = $c->req->params->{browser};
#		
#		$c->stash->{template} = 'harness.tt';
#		
#		$c->detach('View::TT');
#		
#		return;
#	}
#	
#	$c->serve_static_file(file('.', 't', @captures));
#}


=head1 NAME

JSAN::Prove::Controller::Local - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

=head1 AUTHOR

SamuraiJack

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
