#!/usr/bin/env perl
use strict;


my $cores = $ARGV[0];

my $decomposeDict = "system/decomposeParDict";

open my $in,  '<', "$decomposeDict.org"      or die "Can't read old file: $!";
open my $out, '>', $decomposeDict or die "Can't write new file: $!";

while (<$in>){
  s/\{doms\}/$cores/;
  print $out $_;
}

close $out;
close $in;

