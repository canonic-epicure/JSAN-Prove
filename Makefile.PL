# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'JSAN-Prove';
all_from 'lib/JSAN/Prove.pm';

requires 'Catalyst::Runtime' => '5.80002';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
                 
                 
requires 'Catalyst::View::TT';                 
requires 'URI';
requires 'Module::Build::JSAN';
requires 'Proc::Exists';
requires 'Proc::Background';

if ( $^O eq 'MSWin32' ) {
    requires Win32::Process::List;
    requires Win32::Process;
} else {
	requires Proc::ProcessTable;
}

                 
catalyst;

install_script glob('script/jsan-prove');
install_script glob('script/jsan-prove-starter');

auto_install;
WriteAll;
