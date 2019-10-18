#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';


if ($#ARGV != 1) {
    print "usage: Use hostname as first argument and port as second argument.\n";
    exit;
}

$ho = $ARGV[0];
$po = $ARGV[1];


use IO::Socket;
my $sock = new IO::Socket::INET(
    LocalHost => $ho,
    LocalPort => $po,
    Proto     => 'tcp',
    Listen    => 1,
    Reuse     => 1,
);
die "Could not create socket: $!\n" unless $sock;
my $new_sock = $sock->accept();
while (<$new_sock>) {
    print $_;
}
close($sock)