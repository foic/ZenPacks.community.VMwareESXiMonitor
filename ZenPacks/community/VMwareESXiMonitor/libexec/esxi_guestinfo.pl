#!/usr/bin/perl
################################################################################
#
# This program is part of the VMwareESXiMonitor Zenpack for Zenoss.
# Copyright (C) 2014 Eric Enns, Matthias Kittl.
#
# This program can be used under the GNU General Public License version 2
# You can find full information here: http://www.zenoss.com/oss
#
################################################################################
BEGIN { $ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0; }

use strict;
use warnings;
use VMware::VIRuntime;

Opts::parse();
Opts::validate();

Util::connect();

my $vm_views = Vim::find_entity_views(
    view_type => 'VirtualMachine',
    properties => [ 'name', 'config' ]
);

foreach my $vm (@$vm_views) {
    my $name = $vm->name;
    my $memory = $vm->config->hardware->memoryMB;
    my $os = $vm->config->guestFullName;

    print $name . ";" . $memory . ";" . $os . "\n";
}

Util::disconnect();

