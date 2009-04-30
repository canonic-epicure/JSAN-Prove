#!/usr/bin/perl -w

use strict;
use warnings;

use Getopt::Long;
use FindBin;
use lib "$FindBin::Bin/../lib";

$ENV{CATALYST_ENGINE} = 'HTTP::Stopable';

exec 'script/jsan_prove_server.pl';
