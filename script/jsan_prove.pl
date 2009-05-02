#!/usr/bin/perl -w

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Getopt::Long;
use File::Find::Rule;
use Path::Class;
use Proc::Background;

use Data::Dump;

my $help              = 0;
my $host              = undef;
my $port              = $ENV{JSAN_PROVE_PORT} || $ENV{CATALYST_PORT} || 3000;
my @preload 		  = ();
my @browsers 		  = ();		

GetOptions(
    'help|?'              => \$help,
    'host=s'              => \$host,
    'port=s'              => \$port,
    'preload|p=s'	      => \@preload,
    'browser|b=s'	      => \@browsers,
);

my @tests = @ARGV;

if (!@tests) {
	@tests = sort File::Find::Rule->file->name('*.t')->in(dir('t'));
	
	die "No tests found" unless @tests;
	
	@tests = map { file($_)->relative() } @tests;
}

$ENV{JSAN_PROVE_TESTS} = join "\n", @tests;
$ENV{JSAN_PROVE_PRELOAD} = join "\n", @preload;
$ENV{JSAN_PROVE_BROWSERS} = join "\n", @browsers;
$ENV{CATALYST_ENGINE} = 'HTTP::Stopable';

my $proc = Proc::Background->new('perl', 'script/jsan_prove_server.pl');
#my $proc = Proc::Background->new('perl', 'jsan_prove_server.pl');

sleep(1);



use JSAN::Prove::App::Browser::FireFox;


my $ff = JSAN::Prove::App::Browser::FireFox->new();
$ff->start('http://catalyst-dev:3000/prove/firefox');

#$proc->wait;

 

$ff->stop;