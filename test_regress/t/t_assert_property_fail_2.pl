#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);

top_filename("t/t_assert_property.v");

compile(
    v_flags2 => ['+define+FAIL_ASSERT_2'],
    verilator_flags2 => ['--assert --cc'],
    );

execute(
    fails => 1
    );

file_grep($Self->{run_log_filename}, qr/'assert' failed/);

ok(1);
1;
