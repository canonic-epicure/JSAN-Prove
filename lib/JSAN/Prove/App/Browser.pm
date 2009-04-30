package JSAN::Prove::App::Browser;

use Moose;

use File::Find::Rule;
use MooseX::Types::Path::Class qw(Dir File);

use Proc::Background;


#================================================================================================================================================================================================================================================
has 'exe_path' => {
    is => 'rw',
    isa => 'Path::Class::File',
    required => 1,
    coerce   => 1,
};


has 'proc' => {
	is => 'rw'
};



#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub start {
    my $self = shift;
    
    $self->proc(Proc::Background->new($self->exe_path));
}

 
#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub stop {
    my $self = shift;
    
    $self->proc->die();
}

1;