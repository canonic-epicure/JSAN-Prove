package JSAN::Prove::Model::Tests;

use strict;
use warnings;
use parent 'Catalyst::Model';
use Moose;

use File::Find::Rule;

use Path::Class;
use Data::Dump;




has 'urls' => (
	is => 'rw'
);


override 'COMPONENT' => sub {
	my ($self, $c, $arguments) = @_;
	
	$arguments->{urls} = [ sort File::Find::Rule->file->name('*.js')->in($arguments->{t_dir}) ];	
	
	return $self->SUPER::COMPONENT($c, $arguments);
};



=head1 NAME

JSAN::Prove::Model::Browsers - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

SamuraiJack

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
