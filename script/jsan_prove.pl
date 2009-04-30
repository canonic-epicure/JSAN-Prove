#!/usr/bin/perl -w

use strict;
use warnings;

use Getopt::Long;
use FindBin;
use lib "$FindBin::Bin/../lib";

#$ENV{CATALYST_ENGINE} = 'HTTP::Stopable';
#
#exec 'script/jsan_prove_server.pl';

use JSAN::Prove::App::Browser::FireFox;

my $ff = JSAN::Prove::App::Browser::FireFox->new();
$ff->start('http://yahoo.ru');

sleep(3); 

$ff->stop;