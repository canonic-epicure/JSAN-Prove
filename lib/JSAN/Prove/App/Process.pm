package JSAN::Prove::App::Process;

if($^O eq 'MSWin32') {
    require Win32::Process::List;
    require Win32::Process;
    
} else {
    require Proc::ProcessTable;
}

use Proc::Exists qw(pexists);


#================================================================================================================================================================================================================================================
sub kill_by_name {
    my ($self, $name_regex) = @_;
    
    my %name_pid_hash = $self->get_name_pid_hash;
    
    foreach my $pid (keys(%name_pid_hash)) {
    	$self->kill_by_pid($pid) if $name_pid_hash{$pid} =~ /$name_regex/; 
    }
}


#================================================================================================================================================================================================================================================
sub get_name_pid_hash {
	if ($^O eq 'MSWin32') {
		return Win32::Process::List->new->GetProcesses;
	} else {
	    my $process_list = Proc::ProcessTable->new->table;
	    
	    my %name_pid_hash = ();
	    foreach $process (@$process_list) {
	    	$name_pid_hash{$process->pid} = $process->cmndline;
	    }
	    
	    return %name_pid_hash;
	}
}


#================================================================================================================================================================================================================================================
sub kill_by_pid {
	my ($self, $pid) = @_;
	
	if ($^O eq 'MSWin32') {
		my $exit_code;
		
		return Win32::Process::KillProcess($pid, $exit_code)
	} else {
		
		foreach my $signal (qw(HUP INT QUIT KILL)) {
			my $count = 5;
			
			while ($count and pexists($pid)) {
				--$count;
				kill($signal, $pid);
				last SIGNAL unless pexists($pid);
				sleep 1;
			}
		}
	}
}


1;