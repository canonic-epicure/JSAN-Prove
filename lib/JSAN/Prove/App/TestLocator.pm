package JSAN::Prove::App::TestLocator;

use Moose;

use File::Find::Rule;
use Path::Class;
use MooseX::Types::Path::Class qw(Dir File);


#================================================================================================================================================================================================================================================
has 'test_dir' => {
    is => 'rw',
    isa => 'Path::Class::Dir',
    required => 1,
    coerce   => 1,
};



#================================================================================================================================================================================================================================================
#================================================================================================================================================================================================================================================
sub generate_test_list {
    my $self = shift;
    
    return sort File::Find::Rule->file->name('*.js')->in($self->test_dir);
} 

1;